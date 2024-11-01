sealed class ApiState<S, E extends Exception> {
  ApiState();
  // Factory constructor to initialize ApiState with ApiInitial
  factory ApiState.initial() => ApiInitial<S, E>();

  bool get isInitial => this is ApiInitial;
  bool get isLoading => this is ApiLoading;
  bool get isLoaded => this is ApiLoaded;
  bool get isError => this is ApiError;

  T when<T>({
    required T Function() onInitial,
    required T Function() onLoading,
    required T Function(S value) onLoaded,
    required T Function(E exception) onError,
  }) {
    return switch (this) {
      ApiInitial() => onInitial(),
      ApiLoading() => onLoading(),
      ApiLoaded<S, E> loaded => onLoaded(loaded.data),
      ApiError<S, E> error => onError(error.error),
    };
  }
}

class ApiInitial<S, E extends Exception> extends ApiState<S, E> {}

class ApiLoading<S, E extends Exception> extends ApiState<S, E> {}

class ApiLoaded<S, E extends Exception> extends ApiState<S, E> {
  final S data;
  ApiLoaded(this.data);
}

class ApiError<S, E extends Exception> extends ApiState<S, E> {
  final E error;
  ApiError(this.error);
}
