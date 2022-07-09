class UserPill {
  final int id;
  final String name;
  final int amount;
  final String date;
  final String timesADay;
  final String interval;
  final int type;

  UserPill({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.timesADay,
    required this.interval,
    required this.type,
  });

  factory UserPill.fromJson(Map<String, dynamic> json) {
    return UserPill(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
      timesADay: json['timesADay'],
      interval: json['interval'],
      type: json['type'],
    );
  }
}
