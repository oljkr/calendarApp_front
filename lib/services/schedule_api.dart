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

  static Future<List<ScheduleModel>> getSchedule({
    required DateTime date,
  }) async {
    Map<String, String> qParams = {
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
    };
    print(qParams);
    try {
      var url = Uri.parse(BASEURL);
      final finalUri = url.replace(queryParameters: qParams);
      http.Response response = await http.get(
        finalUri,
        headers: headers,
      );
      print(response.body);
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      List responseList = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseList);
      List<ScheduleModel> scheduleList = [];
      for (int x = 0; x < responseList.length; x++) {
        ScheduleModel scheduleModel = ScheduleModel.fromMap(responseList[x]);
        scheduleList.add(scheduleModel);
      }
      return scheduleList;
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<http.Response> createSchedule(
    String? name,
    DateTime? startDate,
    int? startTime,
    int? endTime,
  ) async {
    try {
      var url = Uri.parse(BASEURL);
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(<String, String>{
          'name': '${name}',
          'startDate': '${startDate}',
          'startTime': '${startTime}',
          'endTime': '${endTime}',
        }),
      );
      print(response.body);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<http.Response> deleteSchedule({
    required int scheNo,
  }) async {
    Map<String, String> qParams = {
      'scheNo': '${scheNo}',
    };
    print(qParams);
    try {
      var url = Uri.parse(BASEURL);
      final finalUri = url.replace(queryParameters: qParams);
      http.Response response = await http.delete(
        finalUri,
        headers: headers,
      );
      print(response.body);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
