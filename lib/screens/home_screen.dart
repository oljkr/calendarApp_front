import 'package:flutter/material.dart';
import 'package:calendar_frontend/component/main_calendar.dart';
import 'package:calendar_frontend/component/schedule_card.dart';
import 'package:calendar_frontend/component/today_banner.dart';
import 'package:calendar_frontend/component/schedule_bottom_sheet.dart';
import 'package:calendar_frontend/consts/colors.dart';
import 'package:provider/provider.dart';
import 'package:calendar_frontend/providers/schedule_provider.dart';
import 'package:calendar_frontend/services/schedule_convert.dart';

class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    final selectedDate = provider.selectedDate;
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: (selectedDate, focusedDate) =>
                  onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDate: selectedDate,
              count: schedules.length,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction) {
                      provider.deleteSchedule(scheNo: schedule.scheNo);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 8.0, right: 8.0),
                      child: ScheduleCard(
                        startTime:
                            apiConvertClass.apiConvert(schedule.startDate),
                        endTime: apiConvertClass.apiConvert(schedule.endDate),
                        content: schedule.name,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(
      date: selectedDate,
    );
    provider.getSchedules(date: selectedDate);
  }
}
