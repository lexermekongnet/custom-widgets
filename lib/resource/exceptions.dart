/// Message for unknown errors
const unknownError = 'UNKNOWN ERROR';

/// An exception class designed to throw server related errors
class ServerException implements Exception {
  /// This is the exception message
  final String message;

  /// Creates an instance of [ServerException]
  const ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

/// An exception class designed to throw cache related errors
class CacheException implements Exception {
  /// This is the exception message
  final String message;

  /// Creates an instance of [CacheException]
  const CacheException(this.message);

  @override
  String toString() {
    return message;
  }
}

/// An exception class designed to throw local app related errors
class LocalAppException implements Exception {
  /// This is the exception message
  final String message;

  /// Creates an instance of [LocalAppException]
  const LocalAppException(this.message);

  @override
  String toString() {
    return message;
  }
}

/// An exception class designed to throw local database related errors
class LocalDBException implements Exception {
  /// This is the exception message
  final String message;

  /// Creates an instance of [LocalDBException]
  const LocalDBException(this.message) : super();

  @override
  String toString() {
    return message;
  }
}
