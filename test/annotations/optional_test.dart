library example.optional;

import 'package:ng_di/ng_di.dart';
import 'package:test/test.dart';

part 'optional_test.ng_di.g.dart';

@injectable
class Engine {
}

@injectable
class Car {
  final Engine engine;

  Car(@optional this.engine);
}

class Truck {
  final Engine engine;

  Truck([this.engine]);
}

class Boat {
  final Engine engine;

  Boat({this.engine});
}

@GenerateInjector([Car, Truck, Boat])
final injector = injector$Injector();

main() {
  test('optional', () {
    expect(injector.get(Car).engine, null);
    expect(injector.get(Truck).engine, null);
    expect(injector.get(Boat).engine, null);
  });
}