import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:si_atma/repositories/user_repository.dart';

import '../../models/user.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());

  final key = GlobalKey<FormState>();

  final name = TextEditingController();
  final password = TextEditingController();

  User u = User(
    id: 0,
    name: '',
    password: '',
    createdAt: '',
  );

  bool isObscure = true;

  void setObscure() {
    emit(const UserState.loading());
    isObscure = !isObscure;
    emit(const UserState.tapped());
  }

  void login() async {
    emit(const UserState.loading());
    final user = await UserRepository.login(name.text, password.text);
    user.fold(
      (l) => emit(UserState.error(l.message)),
      (r) {
        u = r;
        emit(UserState.loaded(r));
      },
    );
  }

  void profile() async {
    emit(const UserState.loading());
    final user = await UserRepository.profile();
    user.fold(
      (l) => emit(UserState.error(l.message)),
      (r) {
        u = r;
        emit(UserState.loaded(r));
      },
    );
  }
}
