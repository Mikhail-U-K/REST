part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.error({required String errorMessage}) = _Error;
  const factory AppState.loading() = _Loading;
  const factory AppState.loaded({required List<UserModel> users}) = _Loaded;
}
