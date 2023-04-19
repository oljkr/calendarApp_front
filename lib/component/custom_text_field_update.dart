import 'package:calendar_frontend/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldUpdate extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  const CustomTextFieldUpdate({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          flex: isTime ? 0 : 1,
          child: TextFormField(
            controller: controller,
            onSaved: onSaved,
            validator: validator,
            cursorColor: Colors.grey,
            maxLines: isTime ? 1 : null,
            expands: !isTime,
            keyboardType:
                isTime ? TextInputType.number : TextInputType.multiline,
            inputFormatters: isTime
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
              suffixText: isTime ? '시' : null,
            ),
          ),
        ),
      ],
    );
  }
}
