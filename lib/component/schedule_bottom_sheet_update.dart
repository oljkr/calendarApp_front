import 'package:calendar_frontend/component/custom_text_field_update.dart';
import 'package:flutter/material.dart';
import 'package:calendar_frontend/component/custom_text_field.dart';
import 'package:calendar_frontend/consts/colors.dart';
import 'package:calendar_frontend/models/schedule_model.dart';
import 'package:provider/provider.dart';
import 'package:calendar_frontend/providers/schedule_provider.dart';

class ScheduleBottomSheetUpdate extends StatefulWidget {
  final DateTime selectedDate;
  final int scheNo;
  final String name;
  final int startTime;
  final int endTime;

  const ScheduleBottomSheetUpdate({
    required this.selectedDate,
    required this.scheNo,
    required this.name,
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheetUpdate> createState() =>
      _ScheduleBottomSheetUpdateState();
}

class _ScheduleBottomSheetUpdateState extends State<ScheduleBottomSheetUpdate> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final provider = Provider.of<ScheduleProvider>(context, listen: false);

    List<TextEditingController> controllers = [
      TextEditingController(text: '${widget.startTime}'),
      TextEditingController(text: '${widget.endTime}'),
      TextEditingController(text: '${widget.name}'),
    ];

    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldUpdate(
                        controller: controllers[0],
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextFieldUpdate(
                        controller: controllers[1],
                        label: '종료 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: CustomTextFieldUpdate(
                    controller: controllers[2],
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onSavePressed(context);
                      provider.getSchedules(date: widget.selectedDate);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      context.read<ScheduleProvider>().updateSchedule(
            scheNo: widget.scheNo,
            name: content!,
            startDate: widget.selectedDate,
            startTime: startTime!,
            endTime: endTime!,
          );
      context.read<ScheduleProvider>().getSchedules(date: widget.selectedDate);
      Navigator.of(context).pop();
    }
  }

  String? timeValidator(String? val) {
    if (val == null) {
      return '값을 입력해주세요';
    }

    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }

    if (number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }

  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return '값을 입력해주세요';
    }

    return null;
  }
}
