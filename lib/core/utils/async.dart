import 'package:equatable/equatable.dart';

class Async<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final bool _successWithoutData;
  final bool? _loading;

  const Async._(
      this.data, this.failure, this._successWithoutData, this._loading);

  bool get isLoading => _loading ?? false;

  bool get isSuccess =>
      (_successWithoutData || data != null) && (failure == null);

  bool get isFailure => failure != null;

  bool get isInitial => (data == null)
      && (failure == null)
      && (_successWithoutData == false)
      && (_loading == null);

  const Async.loading() : this._(null, null, false, true);
  const Async.success(T data) : this._(data, null, false, false);
  const Async.successWithoutData() : this._(null, null, true, false);
  const Async.failure(Failure failure)
      : this._(null, failure, false, false);
  const Async.initial() : this._(null, null, false, null);

  @override
  List<Object?> get props =>
      [data, failure, _successWithoutData, _loading];
}
class Failure extends Equatable {
  final String errorMessage;

  const Failure(
      this.errorMessage,
      );

  @override
  List<Object?> get props => [
    errorMessage,
  ];
}