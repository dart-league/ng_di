library example.optional;

import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/ng_di.dart';

part 'optional.g.dart';

@injectable
class Engine {
  String name;

  Engine(@Optional() this.name);
}

@Injectable()
class Car {
  final Engine engine;

  Car(this.engine);
}

main() {
  _initMirrors();

  var injector = createInjector([
    Engine,
    Car
  ]);

  assert(injector.get(Car).engine.name == null);
  print('Carg.engine: ${injector.get(Car).engine.name}');
}