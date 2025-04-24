import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/kv_generator.dart';

Builder kvBuilder(BuilderOptions options) => SharedPartBuilder([KVGenerator()], 'xxf_cache_generator');
