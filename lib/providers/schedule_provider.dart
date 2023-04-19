import 'package:calendar_frontend/models/schedule_model.dart';
import 'package:calendar_frontend/services/schedule_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider with ChangeNotifier {
  ScheduleModel scheduleModel =
      ScheduleModel(scheNo: 0, name: "", startDate: "", endDate: "");
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

  void getDetailSchedules({
    required int scheNo,
  }) async {
    scheduleModel = await ScheduleAPiServices.getDetailSchedule(scheNo: scheNo);
    notifyListeners();
  }

  void createSchedule({
    String? name,
    required DateTime startDate,
    int? startTime,
    int? endTime,
  }) async {
    final targetDate = startDate;
    final uuid = Uuid();

    final tempId = uuid.v4();
    final newSchedule = scheduleModel.copyWith(
      id: tempId,
      name: name,
    );

    cache.update(
      targetDate,
      (value) => [newSchedule],
      ifAbsent: () => [newSchedule],
    );

    notifyListeners();

    try {
      await ScheduleAPiServices.createSchedule(
          name, startDate, startTime, endTime);

      scheduleList = await ScheduleAPiServices.getSchedule(date: targetDate);
      cache.update(
        targetDate,
        (value) => scheduleList,
        ifAbsent: () => scheduleList,
      );
    } catch (e) {
      cache.update(
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }

    notifyListeners();
  }

  void updateSchedule({
    int? scheNo,
    String? name,
    DateTime? startDate,
    int? startTime,
    int? endTime,
  }) async {
    ScheduleAPiServices.updateSchedule(
        scheNo, name, startDate, startTime, endTime);
    notifyListeners();
  }

  void deleteSchedule({
    required int scheNo,
  }) async {
    ScheduleAPiServices.deleteSchedule(scheNo: scheNo);
    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;
    notifyListeners();
  }
}
