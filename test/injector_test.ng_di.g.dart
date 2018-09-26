// GENERATED CODE - DO NOT MODIFY BY HAND

part of injector_test;

// **************************************************************************
// NgDiGenerator
// **************************************************************************

Injector exampleGenerated$Injector([Injector parent]) =>
    new _Injector$exampleGenerated._(parent);

class _Injector$exampleGenerated extends HierarchicalInjector {
  _Injector$exampleGenerated._([Injector parent]) : super(parent);

  var _field0;
  _getdynamic$0() => _field0 ??= ExampleService2();
  var _field1;
  _getdynamic$1() => _field1 ??= ExampleService2();
  var _field2;
  _getdynamic$2() => _field2 ??= r'Hello World';
  var _field3;
  _getdynamic$3() => _field3 ??= 1234;
  var _field4;
  _getdynamic$4() => _field4 ??= true;
  var _field5;
  _getdynamic$5() => _field5 ??= const ExampleService();
  var _field6;
  _getdynamic$6() => _field6 ??= willNeverBeCalled1(inject(MissingService));
  var _field7;
  _getdynamic$7() => _field7 ??=
      willNeverBeCalled2(inject(ExampleService2), inject(ExampleService3));
  var _field8;
  _getdynamic$8() => _field8 ??= r'A';
  var _field9;
  _getdynamic$9() => _field9 ??= r'B';
  var _field10;
  _getdynamic$10() => _field10 ??= r'C';
  var _field11;
  _getdynamic$11() => _field11 ??= r'D';
  var _field12;
  _getdynamic$12() => _field12 ??= 1;
  var _field13;
  _getdynamic$13() => _field13 ??= 2;
  var _field14;
  _getdynamic$14() => _field14 ??= 3;
  var _field15;
  _getdynamic$15() => _field15 ??= 4;
  var _field16;
  _getdynamic$16() => _field16 ??= 5;
  var _field17;
  _getdynamic$17() => _field17 ??= 6;
  var _field18;
  _getdynamic$18() => _field18 ??= r'https://site.com/api/';
  InjectsBaseUrl _field19;
  InjectsBaseUrl _getInjectsBaseUrl$19() =>
      _field19 ??= InjectsBaseUrl(inject(const OpaqueToken<String>('baseUrl')));
  var _field20;
  _getdynamic$20() => _field20 ??= r'ABC123';
  InjectsXsrfToken _field21;
  InjectsXsrfToken _getInjectsXsrfToken$21() =>
      _field21 ??= InjectsXsrfToken(inject(const XsrfToken()));

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, ExampleService)) {
      return _getdynamic$0();
    }
    if (identical(token, ExampleService2)) {
      return _getdynamic$1();
    }
    if (identical(token, const OpaqueToken<dynamic>('stringToken'))) {
      return _getdynamic$2();
    }
    if (identical(token, const OpaqueToken<dynamic>('numberToken'))) {
      return _getdynamic$3();
    }
    if (identical(token, const OpaqueToken<dynamic>('booleanToken'))) {
      return _getdynamic$4();
    }
    if (identical(token, const OpaqueToken<dynamic>('simpleConstToken'))) {
      return _getdynamic$5();
    }
    if (identical(token, ExampleService3)) {
      return _getdynamic$6();
    }
    if (identical(token, ExampleService4)) {
      return _getdynamic$7();
    }
    if (identical(token, const MultiToken<String>('multiStringToken'))) {
      return [_getdynamic$8(), _getdynamic$9()];
    }
    if (identical(token, const CustomMultiString())) {
      return [_getdynamic$10(), _getdynamic$11()];
    }
    if (identical(token, const OpaqueToken<dynamic>('typedToken'))) {
      return _getdynamic$12();
    }
    if (identical(token, const OpaqueToken<String>('typedToken'))) {
      return _getdynamic$13();
    }
    if (identical(token, const OpaqueToken<List>('typedToken'))) {
      return _getdynamic$14();
    }
    if (identical(token, const OpaqueToken<List<String>>('typedToken'))) {
      return _getdynamic$15();
    }
    if (identical(token, const OpaqueToken<dynamic>())) {
      return _getdynamic$16();
    }
    if (identical(token, const OpaqueToken<String>())) {
      return _getdynamic$17();
    }
    if (identical(token, const OpaqueToken<String>('baseUrl'))) {
      return _getdynamic$18();
    }
    if (identical(token, InjectsBaseUrl)) {
      return _getInjectsBaseUrl$19();
    }
    if (identical(token, const XsrfToken())) {
      return _getdynamic$20();
    }
    if (identical(token, InjectsXsrfToken)) {
      return _getInjectsXsrfToken$21();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}

Injector exampleFromModule$Injector([Injector parent]) =>
    new _Injector$exampleFromModule._(parent);

class _Injector$exampleFromModule extends HierarchicalInjector {
  _Injector$exampleFromModule._([Injector parent]) : super(parent);

  var _field0;
  _getdynamic$0() => _field0 ??= const ExampleService2();
  var _field1;
  _getdynamic$1() => _field1 ??= inject(ExampleService2);

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, ExampleService2)) {
      return _getdynamic$0();
    }
    if (identical(token, ExampleService)) {
      return _getdynamic$1();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}

Injector valueProviderExamples$Injector([Injector parent]) =>
    new _Injector$valueProviderExamples._(parent);

class _Injector$valueProviderExamples extends HierarchicalInjector {
  _Injector$valueProviderExamples._([Injector parent]) : super(parent);

  var _field0;
  _getdynamic$0() => _field0 ??= const TestConstNoArgs();
  var _field1;
  _getdynamic$1() =>
      _field1 ??= const TestConstPositionalArgs(r'TestConstPositionalArgs');
  var _field2;
  _getdynamic$2() =>
      _field2 ??= const TestConstNamedArgs(name: r'TestConstNamedArgs');
  var _field3;
  _getdynamic$3() =>
      _field3 ??= const TestConstNamedArgs2(name: r'TestConstNamedArgs2');

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, TestConstNoArgs)) {
      return _getdynamic$0();
    }
    if (identical(token, TestConstPositionalArgs)) {
      return _getdynamic$1();
    }
    if (identical(token, TestConstNamedArgs)) {
      return _getdynamic$2();
    }
    if (identical(token, TestConstNamedArgs2)) {
      return _getdynamic$3();
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}

Injector tokenOrdering$Injector([Injector parent]) =>
    new _Injector$tokenOrdering._(parent);

class _Injector$tokenOrdering extends HierarchicalInjector {
  _Injector$tokenOrdering._([Injector parent]) : super(parent);

  var _field1;
  _getdynamic$1() => _field1 ??= r'B';
  var _field2;
  _getdynamic$2() => _field2 ??= r'A';
  var _field3;
  _getdynamic$3() => _field3 ??= r'B';

  @override
  Object injectFromSelfOptional(Object token,
      [Object orElse = throwIfNotFound]) {
    if (identical(token, const OpaqueToken<String>('duplicateToken'))) {
      return _getdynamic$1();
    }
    if (identical(token, const MultiToken<String>('duplicateMulti'))) {
      return [_getdynamic$2(), _getdynamic$3()];
    }
    if (identical(token, Injector)) {
      return this;
    }
    return orElse;
  }
}
