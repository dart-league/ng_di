// GENERATED CODE - DO NOT MODIFY BY HAND

part of injector_use_value_test;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector example$Injector([Injector parent]) => new _Injector$example._(parent);

class _Injector$example extends HierarchicalInjector {
  _Injector$example._([Injector parent]) : super(parent);

  var _field0;
  _getDynamic$0() => _field0 ??= const ClassWithConstConstructor();
  var _field1;
  _getDynamic$1() =>
      _field1 ??= const ClassWithNamedConstConstructor.someName();
  var _field2;
  _getDynamic$2() => _field2 ??= const ClassWithMultipleConstructors.isConst();
  var _field3;
  _getDynamic$3() =>
      _field3 ??= ClassWithPrivateConstructorAndStaticField.instance;
  var _field4;
  _getDynamic$4() => _field4 ??= topLevelInstance;
  var _field5;
  _getDynamic$5() => _field5 ??= const _ConcreteClass();
  var _field6;
  _getDynamic$6() => _field6 ??= topLevelMethod;
  var _field7;
  _getDynamic$7() => _field7 ??= StaticClass.staticMethod;
  var _field8;
  _getDynamic$8() => _field8 ??= r'5.00 USD';

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, ClassWithConstConstructor)) {
      return _getDynamic$0();
    }
    if (identical(token, ClassWithNamedConstConstructor)) {
      return _getDynamic$1();
    }
    if (identical(token, ClassWithMultipleConstructors)) {
      return _getDynamic$2();
    }
    if (identical(token, ClassWithPrivateConstructorAndStaticField)) {
      return _getDynamic$3();
    }
    if (identical(token, ClassWithPrivateConstructorAndTopLevelField)) {
      return _getDynamic$4();
    }
    if (identical(token, ClassWithRedirectingConstructor)) {
      return _getDynamic$5();
    }
    if (identical(token, const OpaqueToken<int Function(int)>())) {
      return _getDynamic$6();
    }
    if (identical(token, const OpaqueToken<String Function(String)>())) {
      return _getDynamic$7();
    }
    if (identical(token, const OpaqueToken<String>('stringRawToken'))) {
      return _getDynamic$8();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
