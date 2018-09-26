![Build
Status](https://travis-ci.org/dart-league/ng_di.svg?branch=master)

A Dependency Injection package taken from angular DI.

Usage
=====

Create one of the examples shown below

Inject by Type
==============

Create an Injector by using annotation `@GenerateInjector` and pass the
List of types, then the generator will create the respective injector.

    @GenerateInjector([Engine, Car])
    final injector = injector$Injector();

Full code:

    library example.type;

    import 'package:ng_di/ng_di.dart';

    part 'type.ng_di.g.dart';

    @Injectable()
    class Engine {
      String name;

      Engine();
    }

    @Injectable()
    class Car {
      final Engine engine;

      Car(this.engine);
    }

    //tag::injector[]
    @GenerateInjector([Engine, Car])
    final injector = injector$Injector();
    //end::injector[]

    main() {
      assert(injector.get(Car).engine.name == null);

      injector.get(Car).engine.name = 'my-engine';
      assert(injector.get(Car).engine.name == 'my-engine');

      print('Carg.engine.name: ${injector.get(Car).engine.name}');
    }

Inject using `@Inject()` annotation
===================================

In this case you can specify the token corresponding to the dependency
that will be injected. For example:

    library example.inject;

    import 'package:ng_di/ng_di.dart';

    part 'inject.ng_di.g.dart';

    const v4_engine_token = OpaqueToken<String>('v4_engine_token');
    const v8_engine_token = OpaqueToken<String>('v8_engine_token');
    const truck_token = OpaqueToken<String>('truck_token');

    class Engine {
      String name;

      Engine([@Inject(v4_engine_token) this.name]);
    }

    class Car {
      final Engine engine;

      Car(this.engine);
    }

    _truckFactory(String name) => Car(Engine(name));

    @GenerateInjector([
      Provider(v4_engine_token, useValue: 'v4-engine'),
      Provider(v8_engine_token, useValue: 'v8-engine'),
      Engine,
      Car,
      Provider(truck_token, useFactory: _truckFactory, deps: [v8_engine_token])
    ])
    final injector = injector$Injector();

    main() {
      print('Car.engine: ${injector.get(Car).engine.name}');
      assert(injector.get(Car).engine.name == 'v4-engine');
      print('truck.engine: ${injector.get(truck_token).engine.name}');
      assert(injector.get(truck_token).engine.name == 'v8-engine');
    }

Inject using `@Optional()` annotation
=====================================

In this case we can mark dependencies as optional, so if the value is
not injected then a null value is passed. For example:

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

Inject using `@Self()` annotation
=================================

In this case we can mark dependencies as self, so the injector should
retrieve a dependency only from itself. For example:

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

Inject using `@SkipSelf()` annotation
=====================================

In this case we can mark dependencies as optional, so the dependency
resolution should start from the parent injector. For example:

    library example.skip_self;

    import 'package:ng_di/ng_di.dart';

    part 'skip_self.ng_di.g.dart';

    @Injectable()
    class Engine {
      String name;

      Engine();
    }

    @Injectable()
    class Car {
      final Engine engine;

      Car(@SkipSelf() this.engine);
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
