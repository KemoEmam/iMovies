import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_videos_state.freezed.dart';

@freezed
class NowPLayingVideosState<T> with _$NowPLayingVideosState<T> {
  const factory NowPLayingVideosState.initial() = _Initial;

  const factory NowPLayingVideosState.loading() = Loading;
  const factory NowPLayingVideosState.success(T data) = Success<T>;
  const factory NowPLayingVideosState.error({required String error}) = Error;
}
