import 'package:calendar_frontend/models/schedule_model.dart';
import 'package:calendar_frontend/services/schedule_api.dart';
import 'package:flutter/material.dart';

class ScheduleProvider with ChangeNotifier {
  List<ScheduleModel> scheduleList = [];

  List<ScheduleModel> get getScheduleList {
    return scheduleList;
  }

  Future<List<ScheduleModel>> fetchAllSchedule() async {
    scheduleList = await ScheduleAPiServices.getAllSchedule();
    return scheduleList;
  }
}
