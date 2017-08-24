// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.inject;

// **************************************************************************
// Generator: MirrorsGenerator
// **************************************************************************

_Car__Constructor(params) => new Car(params['engine']);

const $$Car_fields_engine =
    const DeclarationMirror(type: Engine, isFinal: true);

const CarClassMirror = const ClassMirror(name: 'Car', constructors: const {
  '': const FunctionMirror(parameters: const {
    'engine': const DeclarationMirror(
        name: 'engine',
        type: Engine,
        annotations: const [const Inject(r'MyEngine')])
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
  initClassMirrors({Car: CarClassMirror});
  initFunctionMirrors({});
}
