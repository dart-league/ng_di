// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.optional;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector injector$Injector([Injector parent]) =>
    new _Injector$injector._(parent);

class _Injector$injector extends HierarchicalInjector {
  _Injector$injector._([Injector parent]) : super(parent);

  Car _field0;
  Car _getCar$0() => _field0 ??= Car(get(Engine, null));
  Truck _field1;
  Truck _getTruck$1() => _field1 ??= Truck(get(Engine, null));
  Boat _field2;
  Boat _getBoat$2() => _field2 ??= Boat(engine: get(Engine, null));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, Car)) {
      return _getCar$0();
    }
    if (identical(token, Truck)) {
      return _getTruck$1();
    }
    if (identical(token, Boat)) {
      return _getBoat$2();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
