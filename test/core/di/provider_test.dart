library angular2.test.di.provider_test;

import 'package:built_mirrors/built_mirrors.dart';

import 'package:test/test.dart';
import 'package:ng_di/ng_di.dart';

part 'provider_test.g.dart';

void main() {
  _initMirrors();

  group('Binding', () {
    test('can create constant from token', () {
      expect(const Provider(Foo).token, Foo);
    });

    test('can create constant from class', () {
      expect(const Provider(Foo, useClass: Bar).useClass, Bar);
    });

    test('can create constant from value', () {
      expect(const Provider(Foo, useValue: 5).useValue, 5);
    });

    test('can create constant from alias', () {
      expect(const Provider(Foo, useExisting: Bar).useExisting, Bar);
    });

    test('can create constant from factory', () {
      expect(const Provider(Foo, useFactory: fn).useFactory, fn);
    });

    test('can be used in annotation', () {
      ClassMirror mirror = reflectType(Annotated);
      var bindings = (mirror.annotations[0] as MyAnnotation).bindings;
      expect(bindings, hasLength(5));
      bindings.forEach((b) {
        expect(b is Provider, true);
      });
    });
  });
}

class Foo {}

class Bar extends Foo {}

fn() => null;

class MyAnnotation extends Annotation  {
  final List bindings;
  const MyAnnotation(this.bindings);
}

@reflectable
@MyAnnotation(const [
  const Provider(Foo),
  const Provider(Foo, useClass: Bar),
  const Provider(Foo, useValue: 5),
  const Provider(Foo, useExisting: Bar),
  const Provider(Foo, useFactory: fn)
])
class Annotated {}
