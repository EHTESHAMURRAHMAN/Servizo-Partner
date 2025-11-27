class KhatabookEntry {
  final String name;
  final double amount;
  final String note;
  final DateTime date;
  final int type; // 0 for Give, 1 for Get

  KhatabookEntry({
    required this.name,
    required this.amount,
    required this.note,
    required this.date,
    required this.type,
  });

  factory KhatabookEntry.fromJson(Map<String, dynamic> json) {
    return KhatabookEntry(
      name: json['name'],
      amount: json['amount'],
      note: json['note'],
      date: DateTime.parse(json['date']),
      type: json['type'], // expecting int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'note': note,
      'date': date.toIso8601String(),
      'type': type,
    };
  }
}
