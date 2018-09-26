library example.optional;

import 'package:ng_di/ng_di.dart';

part 'optional.ng_di.g.dart';

@Injectable()
class Engine {
}

@Injectable()
class Car {
  final Engine engine;

  Car(@Optional() this.engine);
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
  print('Carg.engine: ${injector.get(Car).engine}');
  print('Truck.engine: ${injector.get(Truck).engine}');
  print('Boat.engine: ${injector.get(Boat).engine}');
}