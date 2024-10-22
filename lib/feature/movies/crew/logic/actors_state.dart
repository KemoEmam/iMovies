import 'package:freezed_annotation/freezed_annotation.dart';

part 'actors_state.freezed.dart';

@freezed
class ActorsState<T> with _$ActorsState<T> {
  const factory ActorsState.initial() = _Initial;

  const factory ActorsState.loading() = Loading;
  const factory ActorsState.success(T data) = Success<T>;
  const factory ActorsState.error({required String error}) = Error;
}
