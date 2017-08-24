library example.self;

import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/ng_di.dart';

part 'self.g.dart';

@injectable
class Engine {
  String name;

  Engine();
}

@Injectable()
class Car {
  final Engine engine;

  Car(@Self() this.engine);
}

main() {
  _initMirrors();

  var injector = createInjector([Engine, Car]);

  assert(injector.get(Car).engine.name == null);
  print('Car.engine: ${injector.get(Car).engine.name}');

  resetCache();
  injector = createInjector([Engine]);
  var child = createInjector([Car], injector);

  try {
    print('Car.engine: ${child.get(Car).engine.name == null}');
  } catch (e) {
    print('error: $e');
  }
}