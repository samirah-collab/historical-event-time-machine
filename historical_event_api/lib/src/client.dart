import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'exceptions.dart';
import 'models.dart';

class HistoricalEventApiClient {
  final http.Client _client;

  final Logger _logger = Logger('HistoricalEventApiClient');

  static const String _authority = 'en.wikipedia.org';

  HistoricalEventApiClient(this._client);

  Future<List<HistoricalEvent>> fetchEvents(int month, int day) async {
    _logger.info('Requesting historical events for $month/$day');

    final monthText = month.toString().padLeft(2, '0');
    final dayText = day.toString().padLeft(2, '0');

    final uri = Uri.https(
      _authority,
      '/api/rest_v1/feed/onthisday/events/$monthText/$dayText',
    );

    try {
      final response = await _client
          .get(
            uri,
            headers: {
              'Accept': 'application/json',
              'User-Agent': 'HistoricalEventTimeMachine/1.0',
            },
          )
          .timeout(const Duration(seconds: 15));

      _logger.info('Wikipedia API returned HTTP ${response.statusCode}');

      if (response.statusCode != 200) {
        _logger.warning('Wikipedia API returned an error status.');

        throw HistoricalEventException(
          'Wikipedia rejected the request '
          '(HTTP ${response.statusCode}).',
        );
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw HistoricalEventException('Unexpected JSON response structure.');
      }

      final events = decoded['events'];

      if (events is! List) {
        throw HistoricalEventException(
          'The API response does not contain a valid events list.',
        );
      }

      return events
          .whereType<Map<String, dynamic>>()
          .map(HistoricalEvent.fromJson)
          .toList();
    } on http.ClientException catch (e) {
      _logger.severe('Network connection failed.', e);

      throw HistoricalEventException(
        'Network communication failure occurred.',
        e,
      );
    } on FormatException catch (e) {
      _logger.severe('JSON decoding failed.', e);

      throw HistoricalEventException('Wikipedia returned invalid JSON.', e);
    } on HistoricalEventException {
      rethrow;
    } catch (e) {
      _logger.severe('Unexpected API processing error.', e);

      throw HistoricalEventException(
        'Unexpected API processing failure occurred.',
        e,
      );
    }
  }
}
