class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  String toString() => 'Failure(statusCode: $statusCode, message: $message)';
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}
