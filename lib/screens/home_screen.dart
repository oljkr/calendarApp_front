import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../inner_screens/sche_tile.dart';
import '../models/schedule_model.dart';
import '../providers/schedule_provider.dart';
import '../services/schedule_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ScheduleModel>? schedule;

  getSchedule() async {
    schedule = await ScheduleAPiServices.getAllSchedule();
    Provider.of<ScheduleProvider>(context, listen: false).scheduleList =
        schedule!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return schedule == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Schedule list (${Provider.of<ScheduleProvider>(context).scheduleList.length})',
              ),
              centerTitle: true,
              backgroundColor: Colors.blue[300],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<ScheduleProvider>(
                builder: (context, ScheduleProvider, child) {
                  return ListView.builder(
                      itemCount: ScheduleProvider.scheduleList.length,
                      itemBuilder: (context, index) {
                        ScheduleModel scheduleModel =
                            ScheduleProvider.scheduleList[index];
                        return ScheTile(
                          scheduleModel: scheduleModel,
                          scheduleProvider: ScheduleProvider,
                        );
                      });
                },
              ),
            ),
          );
  }
}
