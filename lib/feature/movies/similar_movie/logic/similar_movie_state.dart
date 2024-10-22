import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_movie_state.freezed.dart';

@freezed
class SimmilarMovieState<T> with _$SimmilarMovieState<T> {
  const factory SimmilarMovieState.initial() = _Initial;

  const factory SimmilarMovieState.loading() = Loading;
  const factory SimmilarMovieState.success(T data) = Success<T>;
  const factory SimmilarMovieState.error({required String error}) = Error;
}
