library example.self;

import 'package:ng_di/ng_di.dart';
import 'package:test/test.dart';

part 'self_test.ng_di.g.dart';

@Injectable()
class Engine {
  String name;

  Engine();
}

@Injectable()
class Car {
  final Engine engine;

  Car(@self this.engine);
}

@GenerateInjector([Engine, Car])
final injector = injector$Injector();

@GenerateInjector([Engine])
final parentInjector = parentInjector$Injector();

@GenerateInjector([Car])
final childInjector = childInjector$Injector(parentInjector);

main() {
  test('self', () {
    expect(injector.get(Car).engine.name, null);
    expect(() => childInjector.get(Car).engine.name, throwsA(TypeMatcher<NoProviderError>()));
  });
}