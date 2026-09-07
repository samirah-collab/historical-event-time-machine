import 'package:historical_event_api/historical_event_api.dart';
import 'package:test/test.dart';

void main() {
  group('HistoricalEvent Model Tests', () {
    test('Successfully converts valid JSON into HistoricalEvent', () {
      final json = {
        'year': 1969,
        'text': 'The Apollo 11 mission landed on the Moon.',
      };

      final event = HistoricalEvent.fromJson(json);

      expect(event.year, equals(1969));
      expect(event.text, equals('The Apollo 11 mission landed on the Moon.'));
    });

    test('Throws exception when JSON is missing required fields', () {
      final invalidJson = {'year': 1969};

      expect(
        () => HistoricalEvent.fromJson(invalidJson),
        throwsA(isA<HistoricalEventException>()),
      );
    });

    test('Throws exception when JSON has incorrect data types', () {
      final invalidJson = {'year': '1969', 'text': 'Invalid year type'};

      expect(
        () => HistoricalEvent.fromJson(invalidJson),
        throwsA(isA<HistoricalEventException>()),
      );
    });
  });
}
