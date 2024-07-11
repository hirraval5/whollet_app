import 'error.dart';

abstract class DataEvent<T> {
  const DataEvent();

  factory DataEvent.loading(bool loading) => LoadingEvent._internal(loading);

  factory DataEvent.success(T data) => SuccessEvent._internal(data);

  factory DataEvent.failure(ApiException exception) => FailureEvent._internal(exception);
}

base class LoadingEvent<T> extends DataEvent<T> {
  final bool loading;

  LoadingEvent._internal(this.loading);

  @override
  String toString() => 'LoadingEvent{loading: $loading}';
}

base class SuccessEvent<T> extends DataEvent<T> {
  final T data;

  SuccessEvent._internal(this.data);

  @override
  String toString() => 'SuccessEvent{data: $data}';
}

base class FailureEvent<T> extends DataEvent<T> {
  final ApiException exception;

  FailureEvent._internal(this.exception);

  @override
  String toString() => 'FailureEvent{exception: $exception}';
}
