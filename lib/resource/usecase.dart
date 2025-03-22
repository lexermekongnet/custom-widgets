import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failures.dart';

/// An abstract class for all use cases
abstract class UseCase<Type, Params> {
  /// This the invocation call of the use case
  ///
  /// [params] is the parameter for use case
  Future<Either<Failure, Type>> call(Params params);
}

/// A empty class to represent calls without a parameter
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
