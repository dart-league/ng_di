import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/src/di/injector/empty.dart';
import 'package:ng_di/src/di/injector/hierarchical.dart';
import 'package:ng_di/src/di/injector/reflective.dart';
import 'package:ng_di/src/di/provider.dart';
import 'package:ng_di/src/di/reflector.dart';


ReflectiveInjector createInjector(List providersOrLists, [
  HierarchicalInjector parent = const EmptyInjector(),
]) {
  for (var providerOrList in providersOrLists) {
    if (providerOrList is Type) {
      var providerOrListCM = reflectType(providerOrList);
      var constructor = providerOrListCM.constructors[''];
      var parameters = constructor.parameters;
      var keys = parameters.keys;

      factory([p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19]) {
        var factoryParams = [p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19];
        var params = {};
        for (var i = 0; i < keys.length; i++) {
          params[keys.elementAt(i)] = factoryParams[i];
        }
        return constructor.call(params);
      };

      registerFactory(providerOrList, factory);
      registerDependencies(providerOrList, _extractDependencies(parameters));
    } else if (providerOrList is Provider) {
      if (providerOrList.useFactory != null) {
        var factory = providerOrList.useFactory;
        var parameters = reflectFunction(factory).parameters;
        registerDependencies(factory, _extractDependencies(parameters));
      }
    }
  }

  return ReflectiveInjector.resolveAndCreate(providersOrLists, parent);
}

List<List> _extractDependencies(Map<String, DeclarationMirror> parameters) =>
    parameters.values.map((p) => [p.type]..addAll(p.annotations ?? [])).toList();