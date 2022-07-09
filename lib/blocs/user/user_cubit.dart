import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:si_atma/repositories/user_repository.dart';

import '../../models/user.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());

  final name = TextEditingController();
  final password = TextEditingController();

  void login() async {
    emit(const UserState.loading());
    final user = await UserRepository.login(name.text, password.text);
    user.fold(
      (l) => emit(UserState.error(l.message)),
      (r) => emit(UserState.loaded(r)),
    );
  }
}
