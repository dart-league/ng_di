library example.inject;

import 'package:ng_di/ng_di.dart';

part 'inject.ng_di.g.dart';

const v4_engine_token = OpaqueToken<String>('v4_engine_token');
const v8_engine_token = OpaqueToken<String>('v8_engine_token');
const truck_token = OpaqueToken<String>('truck_token');

class Engine {
  String name;

  Engine([@Inject(v4_engine_token) this.name]);
}

class Car {
  final Engine engine;

  Car(this.engine);
}

_truckFactory(String name) => Car(Engine(name));

@GenerateInjector([
  Provider(v4_engine_token, useValue: 'v4-engine'),
  Provider(v8_engine_token, useValue: 'v8-engine'),
  Engine,
  Car,
  Provider(truck_token, useFactory: _truckFactory, deps: [v8_engine_token])
])
final injector = injector$Injector();

main() {
  print('Car.engine: ${injector.get(Car).engine.name}');
  assert(injector.get(Car).engine.name == 'v4-engine');
  print('truck.engine: ${injector.get(truck_token).engine.name}');
  assert(injector.get(truck_token).engine.name == 'v8-engine');
}