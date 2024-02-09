import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class EventHistory {
  EventHistory({
    required this.id,
    required this.name,
    required this.org,
    required this.checkIn,
    required this.checkOut,
    required this.hours,
    required this.wasAdjusted,
    this.adjustedTotal,
    this.whoAdjusted,
  });

  final EventID id;
  final String name;
  final String org;
  final DateTime checkIn;
  final DateTime checkOut;
  final double hours;
  final bool wasAdjusted;
  final double? adjustedTotal;
  final String? whoAdjusted;

  factory EventHistory.fromMap(Map<String, dynamic> map) {
    return EventHistory(
      id: map['id'],
      name: map['name'],
      org: map['org'],
      checkIn: DateTime.parse(map['checkIn']),
      checkOut: DateTime.parse(map['checkOut']),
      hours: map['total'],
      wasAdjusted: map['wasAdjusted'],
      adjustedTotal: map['adjustedTotal'],
      whoAdjusted: map['whoAdjusted'],
    );
  }
}
