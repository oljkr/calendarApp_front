import 'package:flutter/material.dart';

import '../models/schedule_model.dart';
import '../providers/schedule_provider.dart';

class ScheTile extends StatelessWidget {
  final ScheduleModel scheduleModel;
  final ScheduleProvider scheduleProvider;

  const ScheTile(
      {super.key, required this.scheduleModel, required this.scheduleProvider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          scheduleModel.name,
        ),
      ),
    );
  }
}
