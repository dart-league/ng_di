library example.skip_self;

import 'package:ng_di/ng_di.dart';
import 'package:test/test.dart';

part 'skip_self_test.ng_di.g.dart';

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
  test('skipSelf', () {
    expect(() => injector.get(Car).engine.name, throwsA(TypeMatcher<NoProviderError>()));
    expect(childInjector.get(Car).engine.name, null);
  });
}