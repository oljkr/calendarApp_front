import 'package:calendar_frontend/consts/theme_helper.dart';
import 'package:calendar_frontend/inner_screens/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSche extends StatefulWidget {
  const AddSche({Key? key}) : super(key: key);

  @override
  State<AddSche> createState() => _AddScheState();
}

class _AddScheState extends State<AddSche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정 추가"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: CustomTextField(
                label: '일정명',
                isTime: false,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: IconButton(
                icon: Icon(Icons.favorite),
                iconSize: 60.0,
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (DateTime date) {},
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  "일정 등록".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(builder: (context) => ProfilePage()),
                //       (Route<dynamic> route) => false);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
