enum BookParseErrorCode {
  unsupportedFormat,
  invalidEncoding,
  invalidContainer,
  unsafeArchive,
  emptyBook,
}

final class BookParseException implements Exception {
  const BookParseException(this.code, [this.details]);

  final BookParseErrorCode code;
  final String? details;

  @override
  String toString() => 'BookParseException($code, $details)';
}
