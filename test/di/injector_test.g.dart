// GENERATED CODE - DO NOT MODIFY BY HAND

part of test.di.injector_test;

// **************************************************************************
// Generator: MirrorsGenerator
// **************************************************************************

_ExampleService__Constructor(params) => new ExampleService();

const ExampleServiceClassMirror =
    const ClassMirror(name: 'ExampleService', constructors: const {
  '': const FunctionMirror(
      parameters: const {}, call: _ExampleService__Constructor)
});
_ExampleService2__Constructor(params) => new ExampleService2();

const ExampleService2ClassMirror =
    const ClassMirror(name: 'ExampleService2', constructors: const {
  '': const FunctionMirror(
      parameters: const {}, call: _ExampleService2__Constructor)
}, superinterfaces: const [
  ExampleService
]);
const createListWithOptionalFunctionMirror = const FunctionMirror(
  name: 'createListWithOptional',
  returnType: const [List, dynamic],
  parameters: const {
    'missing': const DeclarationMirror(
        name: 'missing', type: String, annotations: const [const Optional()])
  },
);
_A__Constructor(params) => new A(params['b']);

const $$A_fields_b = const DeclarationMirror(type: B, isFinal: true);

const AClassMirror = const ClassMirror(name: 'A', constructors: const {
  '': const FunctionMirror(
      parameters: const {'b': const DeclarationMirror(name: 'b', type: B)},
      call: _A__Constructor)
}, fields: const {
  'b': $$A_fields_b
}, getters: const [
  'b'
]);
_B__Constructor(params) => new B(params['c']);

const $$B_fields_c = const DeclarationMirror(type: C, isFinal: true);

const BClassMirror = const ClassMirror(name: 'B', constructors: const {
  '': const FunctionMirror(
      parameters: const {'c': const DeclarationMirror(name: 'c', type: C)},
      call: _B__Constructor)
}, fields: const {
  'c': $$B_fields_c
}, getters: const [
  'c'
]);
_C__Constructor(params) => new C(params['debugMessage']);

const $$C_fields_debugMessage =
    const DeclarationMirror(type: String, isFinal: true);

const CClassMirror = const ClassMirror(name: 'C', constructors: const {
  '': const FunctionMirror(parameters: const {
    'debugMessage': const DeclarationMirror(name: 'debugMessage', type: String)
  }, call: _C__Constructor)
}, fields: const {
  'debugMessage': $$C_fields_debugMessage
}, getters: const [
  'debugMessage'
], methods: const {
  'toString': const FunctionMirror(
    name: 'toString',
    returnType: String,
  )
});

// **************************************************************************
// Generator: InitMirrorsGenerator
// **************************************************************************

_initMirrors() {
  initClassMirrors({
    ExampleService: ExampleServiceClassMirror,
    ExampleService2: ExampleService2ClassMirror,
    A: AClassMirror,
    B: BClassMirror,
    C: CClassMirror
  });
  initFunctionMirrors(
      {createListWithOptional: createListWithOptionalFunctionMirror});
}
