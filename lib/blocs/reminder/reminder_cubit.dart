import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:si_atma/repositories/user_pill_repository.dart';

import '../../models/user_pill.dart';

part 'reminder_state.dart';
part 'reminder_cubit.freezed.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(const ReminderState.initial());

  List<UserPill> userPill = [];

  void getPill(String date) async {
    emit(const ReminderState.loading());
    final pill = await UserPillRepository.getUserPill(date);
    pill.fold(
      (l) {
        userPill.clear();
        emit(ReminderState.error(l.message));
      },
      (r) {
        userPill = r;
        emit(ReminderState.loaded(userPill));
      },
    );
  }
}
