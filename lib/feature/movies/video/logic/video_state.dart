import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_state.freezed.dart';

@freezed
class VideoState<T> with _$VideoState<T> {
  const factory VideoState.initial() = _Initial;

  const factory VideoState.loading() = Loading;
  const factory VideoState.success(T data) = Success<T>;
  const factory VideoState.error({required String error}) = Error;
}
