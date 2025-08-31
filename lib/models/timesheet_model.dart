class TimesheetEntry {
  final String id;
  final String userId;
  final DateTime timestamp;
  final EntryType type;

  TimesheetEntry({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.type,
  });

  factory TimesheetEntry.fromMap(Map<String, dynamic> map) {
    return TimesheetEntry(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
      type: EntryType.values.firstWhere(
        (e) => e.toString() == 'EntryType.${map['type']}',
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
    };
  }
}

enum EntryType { clockIn, breakStart, breakEnd, clockOut }