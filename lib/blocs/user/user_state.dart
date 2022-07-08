part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
