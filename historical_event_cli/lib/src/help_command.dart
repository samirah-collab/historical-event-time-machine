import 'package:historical_event_api/historical_event_api.dart';

import 'command_base.dart';

class HelpCommand extends CliCommand {
  HelpCommand() : super('help', 'Show available commands.');

  @override
  Future<void> execute(
    HistoricalEventApiClient client,
    List<String> arguments,
  ) async {
    print('');
    print('Available Commands');
    print('════════════════════════════════════════');

    print('help      Show available commands.');
    print('query     Search historical events for a specific date.');

    print('');
  }
}
