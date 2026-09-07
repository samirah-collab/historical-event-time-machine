import 'dart:io';

import 'package:logging/logging.dart';

void configureSystemTelemetry() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    stdout.writeln('[${record.level.name}] ${record.time}: ${record.message}');

    if (record.error != null) {
      stdout.writeln('Error: ${record.error}');
    }

    if (record.stackTrace != null) {
      stdout.writeln(record.stackTrace);
    }
  });
}
