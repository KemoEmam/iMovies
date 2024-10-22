abstract class AiringTodaySeriesState<T> {}

class AiringTodaySeriesStateInitial<T> extends AiringTodaySeriesState<T> {}

class AiringTodaySeriesStateLoading<T> extends AiringTodaySeriesState<T> {}

class AiringTodaySeriesStateSuccess<T> extends AiringTodaySeriesState<T> {
  AiringTodaySeriesStateSuccess(this.data);
  final T data;
}

class AiringTodaySeriesStateError<T> extends AiringTodaySeriesState<T> {
  AiringTodaySeriesStateError(this.error);
  final String error;
}
