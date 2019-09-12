library example.type;

import 'package:ng_di/ng_di.dart';

part 'type.g.dart';

@injectable
class Engine {
  String name;

  Engine();
}

@injectable
class Car {
  final Engine engine;

  Car(this.engine);
}

// tag::injector[]
@GenerateInjector([Engine, Car])
final injector = injector$Injector();
// end::injector[]

main() {
  assert(injector.get(Car).engine.name == null);

  injector.get(Car).engine.name = 'my-engine';
  assert(injector.get(Car).engine.name == 'my-engine');

  print('Carg.engine.name: ${injector.get(Car).engine.name}');
}
