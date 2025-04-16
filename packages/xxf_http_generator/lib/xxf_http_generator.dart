library;

import 'package:build/build.dart';

import 'src/generator.dart';

/// Builds generators for `build_runner` to run
Builder xxfHttpBuilder(BuilderOptions options) =>
    generatorFactoryBuilder(options);
