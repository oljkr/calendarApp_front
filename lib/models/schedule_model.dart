import 'package:flutter/cupertino.dart';

class ScheduleModel with ChangeNotifier {
  final int scheNo;
  String name, startDate, endDate, place, memo;

  ScheduleModel({
    required this.scheNo,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.memo,
  });

  factory ScheduleModel.fromMap(Map scheMap) {
    return ScheduleModel(
      scheNo: scheMap['scheNo'] ?? "",
      name: scheMap['name'] ?? "",
      startDate: scheMap['startDate'] ?? "",
      endDate: scheMap['endDate'] ?? "",
      place: scheMap['place'] ?? "",
      memo: scheMap['memo'] ?? "",
    );
  }

  @override
  String toString() {
    return 'schedule {scheNo: $scheNo, name: $name, startDate: $startDate, endDate: $endDate, place: $place, memo: $memo,}';
  }
}
