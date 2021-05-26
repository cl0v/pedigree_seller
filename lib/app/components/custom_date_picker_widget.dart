import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

//TODO: Não está sendo usado

class CustomDatePicker extends StatefulWidget {
  final bool enabled;

  const CustomDatePicker({Key? key, this.enabled = false}) : super(key: key);
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      enabled: widget.enabled,
      icon: Icon(Icons.calendar_today),
      initialValue: '',
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      dateLabelText: 'Data de nascimento',
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
  }
}
