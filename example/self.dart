library example.self;

import 'package:ng_di/ng_di.dart';

part 'self.ng_di.g.dart';

@Injectable()
class Engine {
  String name;

  Engine();
}

@Injectable()
class Car {
  final Engine engine;

  Car(@Self() this.engine);
}

@GenerateInjector([Engine, Car])
final injector = injector$Injector();

@GenerateInjector([Engine])
final parentInjector = parentInjector$Injector();

@GenerateInjector([Car])
final childInjector = childInjector$Injector(parentInjector);

main() {
  assert(injector.get(Car).engine.name == null);
  print('Car.engine: ${injector.get(Car).engine.name}');

  try {
    print('Car.engine: ${childInjector.get(Car).engine.name == null}');
  } catch (e) {
    print('error: $e');
  }
}