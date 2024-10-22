abstract class SeriesVideoState<T> {}

class SeriesVideoStateInitial<T> extends SeriesVideoState<T> {}

class SeriesVideoStateLoading<T> extends SeriesVideoState<T> {}

class SeriesVideoStateSuccess<T> extends SeriesVideoState<T> {
  SeriesVideoStateSuccess(this.data);
  final T data;
}

class SeriesVideoStateError<T> extends SeriesVideoState<T> {
  SeriesVideoStateError(this.error);
  final String error;
}
