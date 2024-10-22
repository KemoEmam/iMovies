import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_state.freezed.dart';

@freezed
class UpcomingState<T> with _$UpcomingState<T> {
  const factory UpcomingState.initial() = _Initial;
  
  const factory UpcomingState.loading() = Loading;
  const factory UpcomingState.success(T data) = Success<T>;
  const factory UpcomingState.error({required String error}) = Error;
}