// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.skip_self;

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
  Car _getCar$1() => _field1 ??= Car(injectFromAncestry(Engine));

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

Injector parentInjector$Injector([Injector parent]) =>
    new _Injector$parentInjector._(parent);

class _Injector$parentInjector extends HierarchicalInjector {
  _Injector$parentInjector._([Injector parent]) : super(parent);

  Engine _field0;
  Engine _getEngine$0() => _field0 ??= Engine();

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, Engine)) {
      return _getEngine$0();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}

Injector childInjector$Injector([Injector parent]) =>
    new _Injector$childInjector._(parent);

class _Injector$childInjector extends HierarchicalInjector {
  _Injector$childInjector._([Injector parent]) : super(parent);

  Car _field0;
  Car _getCar$0() => _field0 ??= Car(injectFromAncestry(Engine));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, Car)) {
      return _getCar$0();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
