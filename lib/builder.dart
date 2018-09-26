import 'package:build/build.dart';
import 'package:ng_di/ng_di_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder builder(_) => new PartBuilder([const NgDiGenerator()], '.ng_di.g.dart');