import 'package:calendar_frontend/providers/schedule_provider.dart';
import 'package:calendar_frontend/screens/home_screen.dart';
import 'package:calendar_frontend/screens/home_screen2.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleProvider>(
      create: (context) => ScheduleProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen2(),
      ),
    );
  }
}
