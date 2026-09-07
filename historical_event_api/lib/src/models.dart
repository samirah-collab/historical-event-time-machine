import 'exceptions.dart';

class HistoricalEvent {
  final int year;
  final String text;

  const HistoricalEvent({required this.year, required this.text});

  factory HistoricalEvent.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'year': int parsedYear, 'text': String parsedText} => HistoricalEvent(
        year: parsedYear,
        text: parsedText,
      ),
      _ => throw HistoricalEventException(
        'Historical event payload failed validation.',
      ),
    };
  }

  @override
  String toString() {
    return '$year - $text';
  }
}
