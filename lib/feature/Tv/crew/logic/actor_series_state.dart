abstract class SeriesActorState<T> {}

class SeriesActorStateInitial<T> extends SeriesActorState<T> {}

class SeriesActorStateLoading<T> extends SeriesActorState<T> {}

class SeriesActorStateSuccess<T> extends SeriesActorState<T> {
  SeriesActorStateSuccess(this.data);
  final T data;
}

class SeriesActorStateError<T> extends SeriesActorState<T> {
  SeriesActorStateError(this.error);
  final String error;
}
