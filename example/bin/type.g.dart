// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.type;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector injector$Injector([Injector parent]) =>
    new _Injector$injector._(parent);

class _Injector$injector extends HierarchicalInjector {
  _Injector$injector._([Injector parent]) : super(parent);

  Engine _field0;
  Engine _getEngine$0() => _field0 ??= Engine();
  Car _field1;
  Car _getCar$1() => _field1 ??= Car(get(Engine));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, Engine)) {
      return _getEngine$0();
    }
    if (identical(token, Car)) {
      return _getCar$1();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
