import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_state.freezed.dart';

@freezed
class PopularState<T> with _$PopularState<T> {
  const factory PopularState.initial() = _Initial;
  
  const factory PopularState.loading() = Loading;
  const factory PopularState.success(T data) = Success<T>;
  const factory PopularState.error({required String error}) = Error;
}