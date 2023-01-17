import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rest_app/models/user_model.dart';
import 'package:rest_app/repositories/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository _repository;
  AppBloc(this._repository) : super(_Loading()) {
    on<_Started>((event, emit) async {
      emit(const _Loading());
      try {
        final users = await _repository.getUser();
        emit(_Loaded(users: users));
      } catch (e) {
        emit(_Error(errorMessage: e.toString()));
      }
    });
  }
}
