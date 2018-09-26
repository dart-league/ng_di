library injector_test;

import 'package:ng_di/ng_di.dart';
import 'package:test/test.dart';

part 'injector_test.ng_di.g.dart';

final throwsNoProviderError = throwsA(_isNoProviderError);
final _isNoProviderError = TypeMatcher<NoProviderError>();

void main() {
  group('Injector', () {
    group('.generate', () {
      final injector = exampleGenerated();

      test('should consider Provider(T) as Provider(T, useClass: T)', () {
        expect(injector.get(ExampleService2), TypeMatcher<ExampleService2>());
      });

      test('should support "useClass"', () {
        expect(injector.get(ExampleService), TypeMatcher<ExampleService2>());
      });

      group('should support "useValue" to a', () {
        test('boolean', () {
          expect(injector.get(booleanToken), true);
        });

        test('number', () {
          expect(injector.get(numberToken), 1234);
        });

        test('string', () {
          expect(injector.get(stringToken), 'Hello World');
        });
      });

      test('should support MultiToken', () {
        final result = injector.get(multiStringToken);
//        expect(
//          result,
//          TypeMatcher<List<String>>(),
//          reason: 'List<String> expected, got $result of ${result.runtimeType}',
//        );
        expect(result, ['A', 'B']);
      });

      test('should support a custom MultiToken', () {
        final result = injector.get(const CustomMultiString());
//        expect(
//          result,
//          TypeMatcher<List<String>>(),
//          reason: 'List<String> expected, got $result of ${result.runtimeType}',
//        );
        expect(result, ['C', 'D']);
      });

      test('should consider opaque tokens with different types unique', () {
        expect(injector.get(typedTokenOfDynamic), 1);
        expect(injector.get(typedTokenOfString), 2);
      });

      test('should consider opaque tokens with nested types unique', () {
        expect(injector.get(typedTokenOfListDynamic), 3);
        expect(injector.get(typedTokenOfListString), 4);
      });

      test('should support unnamed tokens', () {
        expect(injector.get(unnamedTokenOfDynamic), 5);
        expect(injector.get(unnamedTokenOfString), 6);
      });

      test('should throw a readable error message on a 1-node failure', () {
        expect(
              () => injector.get(MissingService),
          throwsA(
            predicate(
                  (e) => '$e'.endsWith('No provider found for $MissingService'),
            ),
          ),
        );
      });

      test('should throw a readable error message on a 2-node failure', () {
        expect(
              () => injector.get(ExampleService3),
          throwsA(
            predicate(
                  (e) => '$e'.contains(''
                  'No provider found for $MissingService: '
                  '$ExampleService3 -> $MissingService.'),
            ),
          ),
        );
      });

      test('should throw a readable error message on a 3-node failure', () {
        expect(
              () => injector.get(ExampleService4),
          throwsA(
            predicate(
                  (e) => '$e'.contains(''
                  'No provider found for $MissingService: '
                  '$ExampleService4 -> $ExampleService3 -> $MissingService.'),
            ),
          ),
        );
      });

      test('should treat an OpaqueToken identical to @Inject', () {
        final InjectsBaseUrl service = injector.get(InjectsBaseUrl);
        expect(service.url, 'https://site.com/api/');
      });

      test('should support a user type that extends OpaqueToken', () {
        expect(injector.get(const XsrfToken()), 'ABC123');
        final InjectsXsrfToken service = injector.get(InjectsXsrfToken);
        expect(service.token, 'ABC123');
      });

      test('should support Module', () {
        expect(
          exampleFromModule().get(ExampleService),
          TypeMatcher<ExampleService2>(),
        );
      });

      test('should support arbitrary const values in ValueProvider', () {
        final injector = valueProviderExamples();
        TestConstNoArgs c1 = injector.get(TestConstNoArgs);
        TestConstPositionalArgs c2 = injector.get(TestConstPositionalArgs);
        TestConstNamedArgs c3 = injector.get(TestConstNamedArgs);
        TestConstNamedArgs2 c4 = injector.get(TestConstNamedArgs2);
        expect(c1, isNotNull);
        expect(c2, isNotNull);
        expect(c2.name, '$TestConstPositionalArgs');
        expect(c3, isNotNull);
        expect(c3.name, '$TestConstNamedArgs');
        expect(c4, isNotNull);
        expect(c4.name, '$TestConstNamedArgs2');
      });
    });

    test('should de-duplicate tokens preferring the last provider', () {
      final injector = tokenOrdering();
      expect(injector.get(duplicateToken), 'B');
      expect(injector.get(duplicateMulti), ['A', 'B']);
    });
  });
}

class ExampleService {
  const ExampleService();
}

class ExampleService2 implements ExampleService {
  const ExampleService2();
}

class ExampleService3 {}

class ExampleService4 {}

class MissingService {}

const stringToken = OpaqueToken('stringToken');
const numberToken = OpaqueToken('numberToken');
const booleanToken = OpaqueToken('booleanToken');
const simpleConstToken = OpaqueToken('simpleConstToken');
const multiStringToken = MultiToken<String>('multiStringToken');

// We are going to expect these are different bindings.
const typedTokenOfDynamic = OpaqueToken('typedToken');
const typedTokenOfString = OpaqueToken<String>('typedToken');

const typedTokenOfListDynamic = OpaqueToken<List>('typedToken');
const typedTokenOfListString = OpaqueToken<List<String>>('typedToken');

const unnamedTokenOfDynamic = OpaqueToken();
const unnamedTokenOfString = OpaqueToken<String>();

Null willNeverBeCalled1(Object _) => null;
Null willNeverBeCalled2(Object _, Object __) => null;

class CustomMultiString extends MultiToken<String> {
  const CustomMultiString();
}

@GenerateInjector([
  Provider(ExampleService, useClass: ExampleService2),
  Provider(ExampleService2),
  Provider(stringToken, useValue: 'Hello World'),
  Provider(numberToken, useValue: 1234),
  Provider(booleanToken, useValue: true),
  Provider(simpleConstToken, useValue: ExampleService()),

  // Example of a runtime failure; MissingService
  Provider(
    ExampleService3,
    useFactory: willNeverBeCalled1,
    deps: [MissingService],
  ),

  // Example of a runtime failure; ExampleService3 -> MissingService.
  Provider(
    ExampleService4,
    useFactory: willNeverBeCalled2,
    // Will find ExampleService2, ExampleService3 will fail (see above).
    deps: [ExampleService2, ExampleService3],
  ),

  ValueProvider.forToken(multiStringToken, 'A'),
  ValueProvider.forToken(multiStringToken, 'B'),
  ValueProvider.forToken(CustomMultiString(), 'C'),
  ValueProvider.forToken(CustomMultiString(), 'D'),

  // We are going to expect these are different bindings.
  Provider(typedTokenOfDynamic, useValue: 1),
  Provider(typedTokenOfString, useValue: 2),

  // We are going to expect these are also different bindings.
  Provider(typedTokenOfListDynamic, useValue: 3),
  Provider(typedTokenOfListString, useValue: 4),

  // We are going to expect these are also different bindings.
  Provider(unnamedTokenOfDynamic, useValue: 5),
  Provider(unnamedTokenOfString, useValue: 6),

  // Tests that @Inject(baseUrl) === @baseUrl
  Provider(baseUrl, useValue: 'https://site.com/api/'),
  InjectsBaseUrl,

  // Tests that class T extends OpaqueToken
  Provider(XsrfToken(), useValue: 'ABC123'),
  InjectsXsrfToken,
])
final InjectorFactory exampleGenerated = exampleGenerated$Injector;

@GenerateInjector.fromModules([
  Module(
    include: [
      Module(
        provide: [
          ValueProvider(ExampleService, ExampleService()),
        ],
      ),
    ],
    provide: [
      ValueProvider(ExampleService2, ExampleService2()),
      ExistingProvider(ExampleService, ExampleService2),
    ],
  ),
])
final InjectorFactory exampleFromModule = exampleFromModule$Injector;

ExampleService createExampleService() => ExampleService();
List createListWith(String item) => [item];

@Injectable()
List createListWithOptional(@Optional() String missing) => [missing];

@Injectable()
class A {
  final B b;
  A(this.b);
}

@Injectable()
class B {
  final C c;
  B(this.c);
}

@Injectable()
class C {
  final String debugMessage;

  C(this.debugMessage);

  @override
  String toString() => 'C: $debugMessage';
}

const baseUrl = OpaqueToken<String>('baseUrl');

@Injectable()
class InjectsBaseUrl {
  final String url;

  // Identical to writing @Inject(baseUrl).
  InjectsBaseUrl(@baseUrl this.url);
}

class XsrfToken extends OpaqueToken<String> {
  const XsrfToken();
}

@Injectable()
class InjectsXsrfToken {
  final String token;

  InjectsXsrfToken(@XsrfToken() this.token);
}

class TestConstNoArgs {
  const TestConstNoArgs();
}

class TestConstPositionalArgs {
  final String name;
  const TestConstPositionalArgs(this.name);
}

class TestConstNamedArgs {
  final String name;
  const TestConstNamedArgs({this.name});
}

class TestConstNamedArgs2 {
  final String name;
  const TestConstNamedArgs2({this.name});
}

const topLevelValue = TestConstNamedArgs2(name: 'TestConstNamedArgs2');
const topLevelProvider = ValueProvider(TestConstNamedArgs2, topLevelValue);

@GenerateInjector([
  ValueProvider(
    TestConstNoArgs,
    TestConstNoArgs(),
  ),
  ValueProvider(
    TestConstPositionalArgs,
    TestConstPositionalArgs('TestConstPositionalArgs'),
  ),
  ValueProvider(
    TestConstNamedArgs,
    TestConstNamedArgs(name: 'TestConstNamedArgs'),
  ),
  topLevelProvider,
])
final InjectorFactory valueProviderExamples = valueProviderExamples$Injector;

const duplicateToken = const OpaqueToken<String>('duplicateToken');
const duplicateMulti = const MultiToken<String>('duplicateMulti');

@GenerateInjector([
  ValueProvider.forToken(duplicateToken, 'A'),
  ValueProvider.forToken(duplicateToken, 'B'),
  ValueProvider.forToken(duplicateMulti, 'A'),
  ValueProvider.forToken(duplicateMulti, 'B'),
])
final InjectorFactory tokenOrdering = tokenOrdering$Injector;