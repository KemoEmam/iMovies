abstract class SeriesDetailsState<T> {}

class SeriesDetailsStateInitial<T> extends SeriesDetailsState<T> {}

class SeriesDetailsStateLoading<T> extends SeriesDetailsState<T> {}

class SeriesDetailsStateSuccess<T> extends SeriesDetailsState<T> {
  SeriesDetailsStateSuccess(this.data);
  final T data;
}

class SeriesDetailsStateError<T> extends SeriesDetailsState<T> {
  SeriesDetailsStateError(this.error);
  final String error;
}
