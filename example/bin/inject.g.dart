// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.inject;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector injector$Injector([Injector parent]) =>
    new _Injector$injector._(parent);

class _Injector$injector extends HierarchicalInjector {
  _Injector$injector._([Injector parent]) : super(parent);

  var _field0;
  _getDynamic$0() => _field0 ??= r'v4-engine';
  var _field1;
  _getDynamic$1() => _field1 ??= r'v8-engine';
  Engine _field2;
  Engine _getEngine$2() => _field2 ??=
      Engine(get(const OpaqueToken<String>('v4_engine_token'), null));
  Car _field3;
  Car _getCar$3() => _field3 ??= Car(get(Engine));
  var _field4;
  _getDynamic$4() => _field4 ??=
      _truckFactory(get(const OpaqueToken<String>(r'v8_engine_token')));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, const OpaqueToken<String>('v4_engine_token'))) {
      return _getDynamic$0();
    }
    if (identical(token, const OpaqueToken<String>('v8_engine_token'))) {
      return _getDynamic$1();
    }
    if (identical(token, Engine)) {
      return _getEngine$2();
    }
    if (identical(token, Car)) {
      return _getCar$3();
    }
    if (identical(token, const OpaqueToken<String>('truck_token'))) {
      return _getDynamic$4();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
