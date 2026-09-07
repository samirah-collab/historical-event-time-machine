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
    if (arguments.isEmpty) {
      print('Error: Please provide a date such as 08/27.'.styleError);
      return;
    }

    final date = arguments.first;
    final parts = date.split('/');

    if (parts.length != 2) {
      print(
        'Error: Invalid date format. Please use MM/DD, such as 08/27.'
            .styleError,
      );
      return;
    }

    final month = int.tryParse(parts[0]);
    final day = int.tryParse(parts[1]);

    if (month == null ||
        day == null ||
        month < 1 ||
        month > 12 ||
        day < 1 ||
        day > 31) {
      print('Error: Invalid date. Please use a valid MM/DD date.'.styleError);
      return;
    }

    try {
      print('Searching historical events for $date...'.styleWarning);

      final events = await client.fetchEvents(month, day);

      final buffer = StringBuffer();

      buffer.writeln();
      buffer.writeln('════════════════════════════════════════'.styleHeader);
      buffer.writeln('       HISTORICAL EVENTS: $date'.styleHeader);
      buffer.writeln('════════════════════════════════════════');

      if (events.isEmpty) {
        buffer.writeln();
        buffer.writeln('No historical events found.');
      }

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
