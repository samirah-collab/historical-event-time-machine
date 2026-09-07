import 'package:historical_event_api/historical_event_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';

class QueryCommand extends CliCommand {
  QueryCommand()
    : super('query', 'Search historical events for a specific date.');

  @override
  Future<void> execute(
    HistoricalEventApiClient client,
    List<String> arguments,
  ) async {
    if (arguments.length < 2) {
      print('Error: Please provide month and day.'.styleError);
      print('Example: query 08 27');
      return;
    }

    final month = int.tryParse(arguments[0]);
    final day = int.tryParse(arguments[1]);

    if (month == null || day == null) {
      print('Error: Month and day must be numbers.'.styleError);
      print('Example: query 08 27');
      return;
    }

    if (month < 1 || month > 12) {
      print('Error: Month must be between 1 and 12.'.styleError);
      return;
    }

    if (day < 1 || day > 31) {
      print('Error: Day must be between 1 and 31.'.styleError);
      return;
    }

    try {
      print('Searching historical events for $month/$day...'.styleWarning);

      final events = await client.fetchEvents(month, day);

      if (events.isEmpty) {
        print('No historical events found for $month/$day.'.styleWarning);
        return;
      }

      final buffer = StringBuffer();

      buffer.writeln();
      buffer.writeln('════════════════════════════════════════'.styleHeader);
      buffer.writeln('       HISTORICAL EVENTS: $month/$day'.styleHeader);
      buffer.writeln('════════════════════════════════════════');

      for (final event in events) {
        buffer.writeln();
        buffer.writeln('${event.year} - ${event.text}'.styleSuccess);
      }

      buffer.writeln();
      buffer.writeln('════════════════════════════════════════');

      print(buffer.toString());
    } on HistoricalEventException catch (e) {
      print('Operation Failed: ${e.message}'.styleError);
    } catch (e) {
      print('Unexpected error: $e'.styleError);
    }
  }
}
