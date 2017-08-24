// GENERATED CODE - DO NOT MODIFY BY HAND

part of angular2.test.di.provider_test;

// **************************************************************************
// Generator: MirrorsGenerator
// **************************************************************************

_Annotated__Constructor(params) => new Annotated();

const AnnotatedClassMirror =
    const ClassMirror(name: 'Annotated', constructors: const {
  '': const FunctionMirror(parameters: const {}, call: _Annotated__Constructor)
}, annotations: const [
  const MyAnnotation(const [
    const Provider(Foo),
    const Provider(Foo, useClass: Bar),
    const Provider(Foo, useValue: 5),
    const Provider(Foo, useExisting: Bar),
    const Provider(Foo, useFactory: fn)
  ])
]);

// **************************************************************************
// Generator: InitMirrorsGenerator
// **************************************************************************

_initMirrors() {
  initClassMirrors({Annotated: AnnotatedClassMirror});
  initFunctionMirrors({});
}
