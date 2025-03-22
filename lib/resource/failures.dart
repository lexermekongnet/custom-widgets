import 'package:equatable/equatable.dart';

/// An abstract class that handles app related error
abstract class Failure extends Equatable {
  /// This is the failure message
  final String message;

  /// Creates an instance of [LocalAppFailure]
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// A failure class designed to handle server related errors
class ServerFailure extends Failure {
  /// Creates an instance of [ServerFailure]
  const ServerFailure(super.message);
}

/// A failure class designed to handle cache related errors
class CacheFailure extends Failure {
  /// Creates an instance of [CacheFailure]
  const CacheFailure(super.message);
}

/// A failure class designed to handle local app related errors
class LocalAppFailure extends Failure {
  /// Creates an instance of [LocalAppFailure]
  const LocalAppFailure(super.message);
}

/// A failure class designed to handle local database related errors
class LocalDBFailure extends Failure {
  /// Creates an instance of [LocalDBFailure]
  const LocalDBFailure(super.message);
}

/// A failure class designed to handle websocket related errors
class WebSocketFailure extends Failure {
  /// Creates an instance of [WebSocketFailure]
  const WebSocketFailure(super.message);
}

/// A failure class designed to handle camera related errors
class CameraFailure extends Failure {
  /// Creates an instance of [CameraFailure]
  const CameraFailure(super.message);
}
