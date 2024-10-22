import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_state.freezed.dart';

@freezed
class MovieDetailsState<T> with _$MovieDetailsState<T> {
  const factory MovieDetailsState.initial() = _Initial;
  
  const factory MovieDetailsState.loading() = Loading;
  const factory MovieDetailsState.success(T data) = Success<T>;
  const factory MovieDetailsState.error({required String error}) = Error;
}