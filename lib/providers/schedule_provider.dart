import 'package:calendar_frontend/models/schedule_model.dart';
import 'package:calendar_frontend/services/schedule_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider with ChangeNotifier {
  List<ScheduleModel> scheduleList = [];

  List<ScheduleModel> get getScheduleList {
    return scheduleList;
  }

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Map<DateTime, List<ScheduleModel>> cache = {};

  void getSchedules({
    required DateTime date,
  }) async {
    scheduleList = await ScheduleAPiServices.getSchedule(date: date);

    cache.update(date, (value) => scheduleList, ifAbsent: () => scheduleList);
    notifyListeners();
  }

  void createSchedule({
    String? name,
    DateTime? startDate,
    int? startTime,
    int? endTime,
  }) async {
    ScheduleAPiServices.createSchedule(name, startDate, startTime, endTime);
    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;
    notifyListeners();
  }
}
