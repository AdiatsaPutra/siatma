part of 'add_reminder_cubit.dart';

@freezed
class AddReminderState with _$AddReminderState {
  const factory AddReminderState.initial() = _Initial;
  const factory AddReminderState.loading() = _Loading;
  const factory AddReminderState.loaded() = _Loaded;
  const factory AddReminderState.success() = _Success;
  const factory AddReminderState.error(String message) = _Error;
}
