library example.inject;

import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/ng_di.dart';

part 'inject.g.dart';

class Engine {
  String name;

  Engine([this.name]);
}

@Injectable()
class Car {
  final Engine engine;

  Car(@Inject("MyEngine") this.engine);
}

main() {
  _initMirrors();

  var engine = new Engine('my-engine');

  var injector = createInjector([
    new Provider("MyEngine", useValue: engine),
    Car
  ]);

  assert(injector.get(Car).engine.name == engine.name);
  print('Carg.engine: ${injector.get(Car).engine.name}');
}