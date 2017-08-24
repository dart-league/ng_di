# ng_di

[![Build Status](https://travis-ci.org/dart-league/ng_di.svg?branch=master)](https://travis-ci.org/dart-league/ng_di)

A Dependency Injection package taken from angular DI.

# Usage

1. create a file `tool/build.dart` and add next code:

```dart
import 'package:build_runner/build_runner.dart';
import 'package:built_mirrors/phase.dart';


main() async {
  // In next line replace `example/**.dart` for the globs you want to use as input, for example `**/*.dart`
  // or leave it empty to take all the dart files of the project as input.
  await build([builtMirrorsAction(const ['example/**.dart'])], deleteFilesByDefault: true);
}

```

2. create one of the examples shown below

3. run `tool/build.dart`

## Inject by Type

In this case you need to annotate classes with `@Injectable()` or `@injectable`. This annotation tells to library
 `built-mirrors` to generate respective mirrors. For example:

```dart
library example.type;

import 'package:built_mirrors/built_mirrors.dart';
import 'package:ng_di/ng_di.dart';

part 'type.g.dart';

@injectable
class Engine {
  String name;

  Engine();
}

@Injectable()
class Car {
  final Engine engine;

  Car(this.engine);
}

main() {
  _initMirrors();

  var injector = createInjector([Engine, Car]);

  assert(injector.get(Car).engine.name == null);
  print('Carg.engine: ${injector.get(Car).engine.name}');
}
```

## Inject using `@Inject()` annotation

In this case you can specify the token corresponding to the dependency that will be injected. For example:

```dart
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
```

## Inject using `@Optional()` or `@optional` annotation

In this case we can mark dependencies as optional, so if the value is not injected then a null value is passed. For
 example:

```dart
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
```

## Inject using `@Self()` or `@self` annotation

In this case we can mark dependencies as self, so the injector should retrieve a dependency only from itself. For
 example:

```dart
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
```

## Inject using `@SkipSelf()` or `@skipSelf` annotation

In this case we can mark dependencies as optional, so the dependency resolution should start from the parent injector.
 For example:

```dart
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
```