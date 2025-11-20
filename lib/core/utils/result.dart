import '../errors/failure.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  Result._({this.data, this.failure});

  bool get isSuccess => failure == null;
  bool get isError => failure != null;

  factory Result.success(T data) {
    return Result._(data: data);
  }

  factory Result.error(Failure failure) {
    return Result._(failure: failure);
  }
}
