class UserPillRequest {
  final int? id;
  final String name;
  final int amount;
  final DateTime time;
  final int timeLasting;
  final int timePerDay;
  final int interval;
  final int type;
  final bool isDone;

  UserPillRequest(
      {this.id,
      required this.name,
      required this.amount,
      required this.time,
      required this.timeLasting,
      required this.timePerDay,
      required this.interval,
      required this.type,
      required this.isDone});

  factory UserPillRequest.fromJson(Map<String, dynamic> json) {
    return UserPillRequest(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      time: json['time'],
      timeLasting: json['timeLasting'],
      timePerDay: json['timePerDay'],
      interval: json['interval'],
      type: json['type'],
      isDone: json['is_done'],
    );
  }
}
