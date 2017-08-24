// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.optional;

// **************************************************************************
// Generator: MirrorsGenerator
// **************************************************************************

_Engine__Constructor(params) => new Engine(params['name']);

const $$Engine_fields_name = const DeclarationMirror(type: String);

const EngineClassMirror =
    const ClassMirror(name: 'Engine', constructors: const {
  '': const FunctionMirror(parameters: const {
    'name': const DeclarationMirror(
        name: 'name', type: String, annotations: const [const Optional()])
  }, call: _Engine__Constructor)
}, fields: const {
  'name': $$Engine_fields_name
}, getters: const [
  'name'
], setters: const [
  'name'
]);
_Car__Constructor(params) => new Car(params['engine']);

const $$Car_fields_engine =
    const DeclarationMirror(type: Engine, isFinal: true);

const CarClassMirror = const ClassMirror(name: 'Car', constructors: const {
  '': const FunctionMirror(parameters: const {
    'engine': const DeclarationMirror(name: 'engine', type: Engine)
  }, call: _Car__Constructor)
}, fields: const {
  'engine': $$Car_fields_engine
}, getters: const [
  'engine'
]);

// **************************************************************************
// Generator: InitMirrorsGenerator
// **************************************************************************

_initMirrors() {
  initClassMirrors({Engine: EngineClassMirror, Car: CarClassMirror});
  initFunctionMirrors({});
}
