import 'package:historical_event_api/historical_event_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class HelpCommand extends CliCommand {
  HelpCommand() : super('help', 'Show available commands.');

  @override
  Future<void> execute(
    HistoricalEventApiClient client,
    List<String> arguments,
  ) async {
    final buffer = StringBuffer();

    buffer.writeln();
    buffer.writeln('════════════════════════════════════════'.styleHeader);
    buffer.writeln('       HISTORICAL EVENT TIME MACHINE'.styleHeader);
    buffer.writeln('════════════════════════════════════════');
    buffer.writeln();
    buffer.writeln('Available Commands:');
    buffer.writeln();
    buffer.writeln('  query MM/DD'.styleSuccess);
    buffer.writeln('      Search historical events for a date.');
    buffer.writeln();
    buffer.writeln('  help'.styleSuccess);
    buffer.writeln('      Display this help message.');
    buffer.writeln();
    buffer.writeln('  exit'.styleSuccess);
    buffer.writeln('      Exit the application.');
    buffer.writeln();
    buffer.writeln('Example: query 08/26'.styleWarning);
    buffer.writeln();

    print(buffer.toString());
  }
}
