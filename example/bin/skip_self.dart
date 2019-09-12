library example.skip_self;

import 'package:ng_di/ng_di.dart';

part 'skip_self.g.dart';

@injectable
class Engine {
  String name;

  Engine();
}

@injectable
class Car {
  final Engine engine;

  Car(@skipSelf this.engine);
}

@GenerateInjector([Engine, Car])
final injector = injector$Injector();

@GenerateInjector([Engine])
final parentInjector = parentInjector$Injector();

@GenerateInjector([Car])
final childInjector = childInjector$Injector(parentInjector);

main() {
  try {
    print('Car.engine: ${injector.get(Car).engine.name == null}');
  } catch (e) {
    print('error: $e');
  }

  assert(childInjector.get(Car).engine.name == null);
  print('Car.engine: ${childInjector.get(Car).engine.name}');
}
