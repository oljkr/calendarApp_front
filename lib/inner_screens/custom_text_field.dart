import 'package:calendar_frontend/consts/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({
    required this.label,
    required this.isTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        cursorColor: Colors.grey,
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: ThemeHelper().textInputDecoration(isTime),
      ),
    );
  }
}
