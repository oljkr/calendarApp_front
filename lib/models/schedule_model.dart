import 'package:flutter/cupertino.dart';

class ScheduleModel with ChangeNotifier {
  final int scheNo;
  String name, startDate, endDate;
  String? place;
  String? memo;

  ScheduleModel({
    required this.scheNo,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.place,
    this.memo,
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

  Map<String, dynamic> toJson() {
    return {
      'scheNo': scheNo,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'place': place,
      'memo': memo,
    };
  }

  @override
  String toString() {
    return 'schedule {scheNo: $scheNo, name: $name, startDate: $startDate, endDate: $endDate, place: $place, memo: $memo,}';
  }

  ScheduleModel copyWith({
    int? scheNo,
    String? name,
    String? startDate,
    String? endDate,
  }) {
    return ScheduleModel(
      scheNo: scheNo ?? this.scheNo,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
