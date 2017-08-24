library example.skip_self;

import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/ng_di.dart';

part 'skip_self.g.dart';

@injectable
class Engine {
  String name;

  Engine();
}

@Injectable()
class Car {
  final Engine engine;

  Car(@SkipSelf() this.engine);
}

main() {
  _initMirrors();

  var injector = createInjector([Engine, Car]);

  try {
    print('Car.engine: ${injector.get(Car).engine.name == null}');
  } catch (e) {
    print('error: $e');
  }

  resetCache();

  injector = createInjector([Engine]);
  var child = createInjector([Car], injector);

  assert(child.get(Car).engine.name == null);
  print('Car.engine: ${child.get(Car).engine.name}');
}