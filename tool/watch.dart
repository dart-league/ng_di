import 'package:build_runner/build_runner.dart';
import 'package:built_mirrors/phase.dart';


main() async {
  await watch([builtMirrorsAction(const ['example/**.dart'])], deleteFilesByDefault: true);
}
