class UserPill {
  final int? id;
  final String name;
  final int amount;
  final String date;
  final String time;
  final int type;
  final int isDone;

  UserPill({
    this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.time,
    required this.type,
    required this.isDone,
  });

  factory UserPill.fromJson(Map<String, dynamic> json) {
    return UserPill(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
      time: json['time'],
      type: json['type'],
      isDone: json['isDone'],
    );
  }
}
