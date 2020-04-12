import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageBodyState createState() {
    return AddPageBodyState();
  }
}

class AddPageBodyState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "Subject": null,
    "Start time": null,
    "End time": null
  };

  @override
  Widget build(buildContext) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      body: SafeArea(child: _content()),
    );
  }

  Widget _content() {
    final PageController controller = PageController(
      initialPage: 0,
    );
    return Form(
      key: _formKey,
      child: PageView(
        onPageChanged: (page) {
          _formKey.currentState.save();
        },
        physics: BouncingScrollPhysics(),
        controller: controller,
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              padding: EdgeInsets.only(
                top: SizeConfig.verticalBlockSize * 8,
                bottom: 16,
                left: SizeConfig.horizontalBlockSize * 9,
                right: SizeConfig.horizontalBlockSize * 9,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeConfig.horizontalBlockSize * 6,
                  right: SizeConfig.horizontalBlockSize * 6,
                  top: SizeConfig.verticalBlockSize * 2,
                  bottom: SizeConfig.verticalBlockSize * 2,
                ),
                margin: EdgeInsets.only(bottom: 32),
                constraints: BoxConstraints(
//                  minHeight: SizeConfig.verticalBlockSize * 60,
                  maxWidth: SizeConfig.horizontalBlockSize * 82,
                ),
                height: SizeConfig.verticalBlockSize * 60,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 42, 42, 1),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: _addFormFields(),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              padding: EdgeInsets.only(
                top: SizeConfig.verticalBlockSize * 8,
                bottom: 16,
                left: SizeConfig.horizontalBlockSize * 9,
                right: SizeConfig.horizontalBlockSize * 9,
              ),
              child: Container(
                padding: EdgeInsets.all(SizeConfig.horizontalBlockSize * 6),
                margin: EdgeInsets.only(bottom: 32),
                constraints: BoxConstraints(
                  minHeight: SizeConfig.verticalBlockSize * 60,
                  maxWidth: SizeConfig.horizontalBlockSize * 82,
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 42, 42, 1),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: Center(child: _addFormTimeFields()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addFormFields() {
    List<bool> selections = List.generate(3, (_) => false);
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: ToggleButtons(
            color: Colors.grey,
            renderBorder: false,
            borderWidth: SizeConfig.horizontalBlockSize * 5,
            children: <Widget>[
              Text(
                "Group",
                style: questrialStyle.copyWith(
                  fontSize: SizeConfig.horizontalBlockSize * 5,
                ),
              ),
              Text(
                "Reminder",
                style: questrialStyle.copyWith(
                  fontSize: SizeConfig.horizontalBlockSize * 5,
                ),
              ),
              Text(
                "Event",
                style: questrialStyle.copyWith(
                  fontSize: SizeConfig.horizontalBlockSize * 5,
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                selections[index] = !selections[index];
              });
            },
            isSelected: selections,
          ),
        ),
        Center(
          child: TextFormField(
            initialValue: formData["Subject"],
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a subject.';
              }
              return null;
            },
            onSaved: (String value) {
              formData["Subject"] = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Subject",
            ),
          ),
        ),
      ],
    );
  }

  Widget _addFormTimeFields() {
    List<bool> selections = List.generate(3, (_) => false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Start time",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 5,
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
        ),
        DateTimeField(
          format: DateFormat("yyyy-MM-dd HH:mm"),
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
          onSaved: (DateTime value) {
            formData["Start time"] = value;
          },
          validator: (value) {
            if (value == null) {
              return 'Please enter a time';
            } else if (value.isBefore(DateTime.now())) {
              return "Please enter a time in the future";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: SizeConfig.horizontalBlockSize * 10,
        ),
        Text(
          "End time",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 5,
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
        ),
        DateTimeField(
          format: DateFormat("HH:mm a"),
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
          onSaved: (DateTime value) {
            formData["End time"] = value;
          },
          validator: (value) {
            if (value == null) {
              return 'Please enter a time';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  bool submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Firestore.instance.collection('Reminders').add(
        {
          "Subject": formData["Subject"],
          "End": Timestamp.fromDate(formData["End time"]),
          "Start": Timestamp.fromDate(formData["Start time"]),
        },
      );
      return true;
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(content: Text('Reminder added.')));
    }
    return false;
  }
}
