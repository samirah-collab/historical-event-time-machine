class HistoricalEventException implements Exception {
  final String message;
  final Object? cause;

  HistoricalEventException(this.message, [this.cause]);

  @override
  String toString() {
    if (cause != null) {
      return 'HistoricalEventException: $message (Underlying: $cause)';
    }

    return 'HistoricalEventException: $message';
  }
}
