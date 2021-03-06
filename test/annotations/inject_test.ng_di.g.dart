// GENERATED CODE - DO NOT MODIFY BY HAND

part of inject_test;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector injector$Injector([Injector parent]) =>
    new _Injector$injector._(parent);

class _Injector$injector extends HierarchicalInjector {
  _Injector$injector._([Injector parent]) : super(parent);

  var _field0;
  _getdynamic$0() => _field0 ??= r'v4-engine';
  var _field1;
  _getdynamic$1() => _field1 ??= r'v8-engine';
  Engine _field2;
  Engine _getEngine$2() => _field2 ??= Engine(injectOptionalUntyped(
      const OpaqueToken<String>('v4_engine_token'), null));
  Car _field3;
  Car _getCar$3() => _field3 ??= Car(inject(Engine));
  var _field4;
  _getdynamic$4() => _field4 ??=
      _truckFactory(inject(const OpaqueToken<String>(r'v8_engine_token')));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, const OpaqueToken<String>('v4_engine_token'))) {
      return _getdynamic$0();
    }
    if (identical(token, const OpaqueToken<String>('v8_engine_token'))) {
      return _getdynamic$1();
    }
    if (identical(token, Engine)) {
      return _getEngine$2();
    }
    if (identical(token, Car)) {
      return _getCar$3();
    }
    if (identical(token, const OpaqueToken<String>('truck_token'))) {
      return _getdynamic$4();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
