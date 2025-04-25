import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/preferences_generator.dart';

Builder preferencesBuilder(BuilderOptions options) => SharedPartBuilder([PreferencesGenerator()], 'xxf_cache_generator');
