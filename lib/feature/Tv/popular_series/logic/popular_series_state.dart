abstract class PopularSeriesState<T> {}

class PopularSeriesStateInitial<T> extends PopularSeriesState<T> {}

class PopularSeriesStateLoading<T> extends PopularSeriesState<T> {}

class PopularSeriesStateSuccess<T> extends PopularSeriesState<T> {
  PopularSeriesStateSuccess(this.data);
  final T data;
}

class PopularSeriesStateError<T> extends PopularSeriesState<T> {
  PopularSeriesStateError(this.error);
  final String error;
}
