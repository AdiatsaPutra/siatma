part of 'reminder_cubit.dart';

@freezed
class ReminderState with _$ReminderState {
  const factory ReminderState.initial() = _Initial;
  const factory ReminderState.loading() = _Loading;
  const factory ReminderState.loaded(List<UserPill> userPill) = _Loaded;
  const factory ReminderState.error(String message) = _Error;
}
