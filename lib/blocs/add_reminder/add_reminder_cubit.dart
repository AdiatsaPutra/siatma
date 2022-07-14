import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:si_atma/models/user.dart';
import 'package:si_atma/models/user_pill_request.dart';

import '../../models/user_pill.dart';
import '../../repositories/user_pill_repository.dart';

part 'add_reminder_state.dart';
part 'add_reminder_cubit.freezed.dart';

class AddReminderCubit extends Cubit<AddReminderState> {
  AddReminderCubit() : super(const AddReminderState.initial());

  final pillName = TextEditingController();
  final pillAmount = TextEditingController();
  final pillTime = TextEditingController();
  final pillTimes = TextEditingController();
  final pillConsumption = TextEditingController();
  final key = GlobalKey<FormState>();
  DateTime? time;
  int? id;
  double day = 1;
  late int? selectedCategory;

  void setWeek(double day) {
    emit(const AddReminderState.loading());
    this.day = day;
    emit(const AddReminderState.loaded());
  }

  void setCategory(int category) {
    emit(const AddReminderState.loading());
    selectedCategory = category;
    emit(const AddReminderState.loaded());
  }

  void setDate(DateTime time) {
    emit(const AddReminderState.loading());
    pillTime.text = DateFormat('yyyy-MM-dd HH:mm').format(time);
    this.time = time;
    emit(const AddReminderState.loaded());
  }

  void addReminder(User u) async {
    emit(const AddReminderState.loading());
    final request = UserPillRequest(
        name: pillName.text,
        amount: int.parse(pillAmount.text),
        time: time!,
        timeLasting: day.toInt(),
        timePerDay: int.parse(pillTimes.text),
        interval: int.parse(pillConsumption.text),
        type: selectedCategory!,
        isDone: 0);

    final reminder = await UserPillRepository.createUserPill(u, request);
    reminder.fold(
      (l) => emit(AddReminderState.error(l.message)),
      (r) => emit(const AddReminderState.success()),
    );
  }

  void deleteReminder(UserPill userPill) async {
    emit(const AddReminderState.loading());
    final delete = await UserPillRepository.deleteUserPill(userPill.id);
    delete.fold(
      (l) => emit(AddReminderState.error(l.message)),
      (r) => emit(const AddReminderState.success()),
    );
  }

  void editReminder(UserPill userPill, int isDone) async {
    emit(const AddReminderState.loading());
    final update =
        await UserPillRepository.updateUserPill(userPill.id!, userPill);
    update.fold(
      (l) => emit(AddReminderState.error(l.message)),
      (r) => emit(const AddReminderState.success()),
    );
  }
}
