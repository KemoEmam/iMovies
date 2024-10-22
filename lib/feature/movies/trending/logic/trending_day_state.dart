import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_day_state.freezed.dart';

@freezed
class TrendingDayState<T> with _$TrendingDayState<T> {
  const factory TrendingDayState.initial() = _Initial;
  
  const factory TrendingDayState.loading() = Loading;
  const factory TrendingDayState.success(T data) = Success<T>;
  const factory TrendingDayState.error({required String error}) = Error;
}