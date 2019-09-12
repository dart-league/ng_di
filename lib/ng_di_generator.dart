import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:angular/di.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

class NgDiGenerator extends GeneratorForAnnotation<GenerateInjector> {
  const NgDiGenerator();

  @override
  generateForAnnotatedElement(covariant VariableElement element, ConstantReader annotation, BuildStep buildStep) {
    var injectorName = element.name;

    var i = -1;

    Map<String, Map<String, dynamic>> renderedTokens = <String, Map<String, dynamic>>{};

    void _renderProvider(DartObject provider) {
      i++;
      var providerCr = ConstantReader(provider);

      if (providerCr.isType) {
        var name = providerCr.typeValue.name;
        ClassElement classElement = providerCr.typeValue.element;
        var parameters = classElement.unnamedConstructor.parameters;

        renderedTokens[name] = {
          'fields': '$name _field$i;'
              ' $name _get$name\$$i() => _field$i ??= $name(${parameters.map((p) => _renderInject(p)).join(',')});',
          'returns': '_get$name\$$i()'
        };
        return;
      }

      if (providerCr.objectValue.type.element.name == 'Module') {
        i--;
        providerCr.read('provide').listValue.forEach(_renderProvider);
        return;
      }

      var tokenCr = providerCr.read('token');
      ClassElement tokenCe = tokenCr.objectValue.type.element;

      var renderedTokenValue = _renderTokenValue(providerCr);
      var isNotMultiToken = tokenCe.name != 'MultiToken' && !tokenCe.allSupertypes.any((st) => st.name == 'MultiToken');

      if (isNotMultiToken) {
        renderedTokens[renderedTokenValue] = {
          'fields': 'var _field$i; _getDynamic\$$i() => _field$i ??= ${_renderValueOrFactory(providerCr)};',
          'returns': '_getDynamic\$$i()'
        };
      } else {
        if (renderedTokens[renderedTokenValue] != null) {
          renderedTokens[renderedTokenValue]['fields']
              .add('var _field$i; _getDynamic\$$i() => _field$i ??= ${_renderValueOrFactory(providerCr)};');
          renderedTokens[renderedTokenValue]['returns']
              .add('_getDynamic\$$i()');
        } else {
          renderedTokens[renderedTokenValue] = {
            'fields': ['var _field$i; _getDynamic\$$i() => _field$i ??= ${_renderValueOrFactory(providerCr)};'],
            'returns': ['_getDynamic\$$i()']
          };
        }
      }
    }

    annotation.revive().positionalArguments[0].toListValue().forEach((v) => _renderProvider(v));

    return '''Injector $injectorName\$Injector([Injector parent]) =>  new _Injector\$$injectorName._(parent);

class _Injector\$$injectorName extends HierarchicalInjector {
  _Injector\$$injectorName._([Injector parent]) : super(parent);

  ${renderedTokens.values.map((v) => v['fields'] is List ? v['fields'].join('\n') : v['fields']).join('\n')}

  @override
  Object injectFromSelfOptional(Object token, [Object orElse = throwIfNotFound]) {
    ${renderedTokens.keys.map((k) => 'if (identical(token, $k)) {'
        ' return ${renderedTokens[k]['returns'] is List
        ? '[${renderedTokens[k]['returns'].join(',')}]'
        : renderedTokens[k]['returns']};}').join('\n')}
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
''';
  }
}

String _renderInject(ParameterElement p) {
  if (p.metadata.any((a) => a.computeConstantValue().type.element.name == 'Optional') || p.isOptional) {
    return '${p.isNamed ? p.name + ': ' : ''}get(${_renderToken(p)}, null)';
  }

  if (p.metadata.any((a) => a.computeConstantValue().type.element.name == 'Self')) {
    return 'injectFromSelf(${_renderToken(p)})';
  }

  if (p.metadata.any((a) => a.computeConstantValue().type.element.name == 'SkipSelf')) {
    return 'injectFromAncestry(${_renderToken(p)})';
  }

  return 'get(${_renderToken(p)})';
}

String _renderToken(ParameterElement p) {
  var injectAnnotation = p.metadata.firstWhere((a) => a.computeConstantValue().type.element.name == 'Inject',
      orElse: () => null);
  if (injectAnnotation != null) {
    return _renderTokenValue(ConstantReader(injectAnnotation.computeConstantValue()));
  }

  var tokenAnnotation = p.metadata.firstWhere((a) =>
      a.constantValue.type.element.name == 'OpaqueToken' ||
      (a.constantValue.type.element as ClassElement).allSupertypes.any((st) => st.name == 'OpaqueToken'),
      orElse: () => null);
  if (tokenAnnotation != null) {
    var tokenPosArgs = ConstantReader(tokenAnnotation.constantValue).revive().positionalArguments;
    return 'const ${tokenAnnotation.constantValue.type}(${tokenPosArgs.isNotEmpty ? "'${tokenPosArgs[0].toStringValue()}'" : ''})';
  }

  return '${p.type.name}';
}

String _renderTokenValue(ConstantReader cr) {
  var tokenCr = cr.read('token');
  if (tokenCr.isType) {
    return tokenCr.typeValue.toString();
  }

  ClassElement tokenCe = tokenCr.objectValue.type.element;
  var typeArgs = tokenCr.objectValue.type.typeArguments;

  var tokenPosArgs = tokenCr.revive().positionalArguments;
  return 'const ${tokenCe.name}${_renderTypeArgs(typeArgs)}(${tokenPosArgs.isNotEmpty
      ? "'${tokenPosArgs[0].toStringValue()}'"
      : ''})';
}

String _renderTypeArgs(List<DartType> typeArgs) => typeArgs.isNotEmpty
    ? '<${typeArgs.map(_renderTypeArg).join(',')}>'
    : '';

String _renderTypeArg(DartType typeArg) {
  if (typeArg is FunctionType) {
    return '${typeArg.returnType} Function(${typeArg.parameters.join(',')})';
  }

  return typeArg.displayName;
}

String _renderValueOrFactory(ConstantReader cr) {
  var valueCr = cr.read('useValue');
  if (!(valueCr.isString && valueCr.stringValue == noValueProvided)) {

    return _renderValue(valueCr.objectValue);
  }

  var factoryCr = cr.read('useFactory');
  var depsCr = cr.read('deps');
  if (factoryCr != null && !factoryCr.isNull) {
    FunctionElement factoryElement = factoryCr.objectValue.type.element;
    return '${factoryElement.displayName}(${_renderDeps(depsCr)})';
  }

  var classCr = cr.read('useClass');
  if (classCr != null && !classCr.isNull) {
    ClassElement classElement = classCr.typeValue.element;
    return '${classElement.name}()';
  }

  var existingCr = cr.read('useExisting');
  if (existingCr != null && !existingCr.isNull) {
    ClassElement classElement = existingCr.typeValue.element;
    return 'get(${classElement.name})';
  }

  return '${cr.read('token').typeValue.name}()';
}

String _renderValue(DartObject value) {
  var vtElement = value.type.element;
  if (vtElement is FunctionElement && vtElement.isStatic) {
    return vtElement.displayName;
  }

  if (vtElement is MethodElement && vtElement.isStatic) {
    return '${vtElement.enclosingElement.displayName}.${vtElement.displayName}';
  }

  if (value.type is FunctionType) {
    return vtElement.displayName;
  }

  var cr = new ConstantReader(value);

  if (cr.isString) return "r'${cr.stringValue}'";
  if (cr.isList) {
    return 'const [${cr.listValue.map((v) => _renderValue(v)).join(',')}]';
  }
  if (cr.isMap) {
    var values = [];
    cr.mapValue.forEach((k, v) => values.add("${_renderValue(k)}: ${_renderValue(v)}"));
    return 'const {${values.join(',')}}';
  }
  if (cr.isLiteral) return cr.literalValue.toString();
  if (cr.isType) return cr.typeValue.toString();

  var revived = cr.revive();

  if (revived.source.fragment.isEmpty) {
    return revived.accessor;
  }

  var arguments = revived.positionalArguments.map(_renderValue).toList();
  revived.namedArguments.forEach((k, v) => arguments.add('$k: ${_renderValue(v)}'));
  return 'const ${value.type.displayName}${revived.accessor.isNotEmpty ? '.' + revived.accessor : ''}(${arguments.join(',')})';
}

String _renderDeps(ConstantReader depsCr) {
  if (depsCr != null && depsCr.isList) {
    return '${depsCr.listValue.map((v) => 'get(${_renderValue(v)})').join(',')}';
  }

  return '';
}
