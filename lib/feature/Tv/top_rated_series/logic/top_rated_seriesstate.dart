abstract class TopRatedSeriesState<T> {}

class TopRatedSeriesStateInitial<T> extends TopRatedSeriesState<T> {}

class TopRatedSeriesStateLoading<T> extends TopRatedSeriesState<T> {}

class TopRatedSeriesStateSuccess<T> extends TopRatedSeriesState<T> {
  TopRatedSeriesStateSuccess(this.data);
  final T data;
}

class TopRatedSeriesStateError<T> extends TopRatedSeriesState<T> {
  TopRatedSeriesStateError(this.error);
  final String error;
}
