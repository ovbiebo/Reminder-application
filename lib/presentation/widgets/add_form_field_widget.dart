import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

import 'customToggleButtons.dart';

///Created by Demilade Oladugba on 4/20/2020

class AddFormField extends StatefulWidget {
  final Map<String, dynamic> formData;

  const AddFormField({Key key, this.formData}) : super(key: key);

  @override
  _AddFormFieldState createState() => _AddFormFieldState();
}

class _AddFormFieldState extends State<AddFormField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: CustomToggleButtons(
            items: ["Group", "Reminder", "Event"],
            selections: [false, true, false],
            itemConstraints: BoxConstraints.tightFor(
              width: SizeConfig.horizontalBlockSize * 24.0,
              height: SizeConfig.verticalBlockSize * 8.0,
            ),
          ),
        ),
        Center(
          child: TextFormField(
            maxLines: 3,
            minLines: 1,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.white,
            initialValue: widget.formData["Subject"],
            validator: (value) {
              return (value.isEmpty) ? 'Please enter a subject.' : null;
            },
            onSaved: (String value) {
              widget.formData["Subject"] = value;
            },
            textAlign: TextAlign.center,
            style: largeTextfieldStyle,
            decoration: largeTextfieldDecoration.copyWith(
              hintText: "Subject",
            ),
          ),
        ),
      ],
    );
  }
}
