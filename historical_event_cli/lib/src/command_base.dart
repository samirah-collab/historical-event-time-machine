import 'package:historical_event_api/historical_event_api.dart';

abstract class CliCommand {
  final String name;
  final String description;

  CliCommand(this.name, this.description);

  Future<void> execute(HistoricalEventApiClient client, List<String> arguments);
}
