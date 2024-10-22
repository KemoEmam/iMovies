abstract class SearchState<T> {}

class SearchStateInitial<T> extends SearchState<T> {}

class SearchStateLoading<T> extends SearchState<T> {}

class SearchStateSuccess<T> extends SearchState<T> {
  SearchStateSuccess(this.data);
  final T data;
}

class SearchStateError<T> extends SearchState<T> {
  SearchStateError(this.error);
  final String error;
}

class SearchStateEmpty<T> extends SearchState<T> {}
