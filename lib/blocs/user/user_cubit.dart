import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_atma/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final name = TextEditingController();
  final password = TextEditingController();

  void login(String name, String password) {
    emit(UserLoading());
    try {
      UserRepository.login(name, password);
      emit(UserLoaded());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
