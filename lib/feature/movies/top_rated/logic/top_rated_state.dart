abstract class TopRatedState<T> {}

class TopRatedStateInitial<T> extends TopRatedState<T> {}

class TopRatedStateLoading<T> extends TopRatedState<T> {}

class TopRatedStateSuccess<T> extends TopRatedState<T> {
  TopRatedStateSuccess(this.data);
  final T data;
}

class TopRatedStateError<T> extends TopRatedState<T> {
  TopRatedStateError(this.error);
  final String error;
}
