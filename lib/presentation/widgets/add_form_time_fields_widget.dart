import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

import 'contextualMenu.dart';
import 'customToggleButtons.dart';
import 'durationPicker.dart';

///Created by Demilade Oladugba on 4/20/2020

class AddFormTimeField extends StatefulWidget {
  final Map<String, dynamic> formData;

  const AddFormTimeField({Key key, this.formData}) : super(key: key);

  @override
  _AddFormTimeFieldState createState() => _AddFormTimeFieldState();
}

class _AddFormTimeFieldState extends State<AddFormTimeField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: CustomToggleButtons(
            items: ["S", "M", "T", "W", "T", "F", "S"],
            selections: List.generate(
                7, (i) => (i == DateTime.now().weekday) ? true : false),
            itemConstraints: BoxConstraints.tightFor(
              width: SizeConfig.horizontalBlockSize * 10.0,
              height: SizeConfig.verticalBlockSize * 8.0,
            ),
          ),
        ),
        Center(
          child: TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            validator: (value) {
              return (value.isEmpty) ? 'Please enter a time.' : null;
            },
            onSaved: (String value) {
              widget.formData["Start"] = value;
            },
            textAlign: TextAlign.center,
            style: largeTextfieldStyle,
            decoration: largeTextfieldDecoration.copyWith(
              hintText: "08:00",
            ),
          ),
        ),
//        DateTimeField(
//          format: DateFormat("HH:mm a"),
//          onShowPicker: (context, currentValue) async {
//            final time = await showTimePicker(
//              context: context,
//              initialTime:
//                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//            );
//            return DateTimeField.convert(time);
//          },
//          onSaved: (DateTime value) {
//            widget.formData["End time"] = value;
//          },
//          validator: (value) {
//            if (value == null) {
//              return 'Please enter a time';
//            } else {
//              return null;
//            }
//          },
//        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ContextualMenu(
            menu: DurationPicker(),
            child: Container(
              padding: EdgeInsets.all(SizeConfig.verticalBlockSize * 3),
              color: Colors.transparent,
              child: Text(
                "For 5 minutes",
                style: questrialStyle.copyWith(
                  decoration: TextDecoration.underline,
                  fontSize: SizeConfig.horizontalBlockSize * 5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}