import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:calendar_frontend/consts/api_consts.dart';
import 'package:calendar_frontend/models/schedule_model.dart';

import '../consts/http_exceptions.dart';
import '../models/schedule_model.dart';

class ScheduleAPiServices {
  static Future<List<ScheduleModel>> getAllSchedule() async {
    try {
      var url = Uri.parse(BASEURL);
      http.Response response = await http.get(
        url,
        headers: headers,
      );
      print(response.body);
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      List responseList = jsonDecode(utf8.decode(response.bodyBytes));
      List<ScheduleModel> scheduleList = [];
      for (Map scheMap in responseList) {
        ScheduleModel scheduleModel = ScheduleModel.fromMap(scheMap);
        scheduleList.add(scheduleModel);
      }
      return scheduleList;
    } catch (error) {
      throw error.toString();
    }
  }
}
