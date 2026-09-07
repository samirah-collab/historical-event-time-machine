import 'dart:io';

import 'package:historical_event_api/historical_event_api.dart';
import 'package:historical_event_cli/src/command_base.dart';
import 'package:historical_event_cli/src/help_command.dart';
import 'package:historical_event_cli/src/logging_config.dart';
import 'package:historical_event_cli/src/query_command.dart';
import 'package:http/http.dart' as http;
import 'package:terminal_colors/terminal_colors.dart';

Future<void> main() async {
  // Start logging/telemetry.
  configureSystemTelemetry();

  // Create HTTP client and API client.
  final httpClient = http.Client();
  final apiClient = HistoricalEventApiClient(httpClient);

  // Create CLI commands.
  final commands = <CliCommand>[HelpCommand(), QueryCommand()];

  print('');
  print('========================================'.styleHeader);
  print('    HISTORICAL EVENT TIME MACHINE'.styleHeader);
  print('========================================'.styleHeader);
  print('');
  print('Type "help" to see available commands.');
  print('Type "exit" to close the program.');

  try {
    while (true) {
      stdout.write('\nhistorical_event > ');

      final input = stdin.readLineSync();

      // Stop if input is closed.
      if (input == null) {
        break;
      }

      final trimmed = input.trim();

      // Ignore empty input.
      if (trimmed.isEmpty) {
        continue;
      }

      // Exit command.
      if (trimmed.toLowerCase() == 'exit') {
        print('Exiting Historical Event Time Machine...'.styleWarning);
        break;
      }

      // Split command and arguments.
      final parts = trimmed.split(RegExp(r'\s+'));
      final commandName = parts.first.toLowerCase();
      final arguments = parts.sublist(1);

      // Find the requested command.
      CliCommand? selectedCommand;

      for (final command in commands) {
        if (command.name == commandName) {
          selectedCommand = command;
          break;
        }
      }

      // Unknown command.
      if (selectedCommand == null) {
        print('Unknown command: $commandName'.styleError);
        print('Type "help" to see available commands.');
        continue;
      }

      // Execute the selected command.
      await selectedCommand.execute(apiClient, arguments);
    }
  } finally {
    // Always close the HTTP client.
    httpClient.close();

    print('');
    print('Network connection closed successfully.'.styleSuccess);
  }
}
