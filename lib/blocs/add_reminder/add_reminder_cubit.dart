import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_reminder_state.dart';
part 'add_reminder_cubit.freezed.dart';

class AddReminderCubit extends Cubit<AddReminderState> {
  AddReminderCubit() : super(const AddReminderState.initial());

  double day = 1;
  int? selectedCategory;

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
}
