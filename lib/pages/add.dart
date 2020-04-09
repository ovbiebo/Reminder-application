import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vsfluttertest/utils/constants.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: FlatButton(
          child: Text(
            "cancel",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 6,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              submit();
            },
          ),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 6,
          )
        ],
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: SizeConfig.horizontalBlockSize * 9,
        right: SizeConfig.horizontalBlockSize * 9,
      ),
      children: <Widget>[
        Container(
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
          child: Center(child: _addForm()),
        ),
      ],
    );
  }

  Widget _addForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Subject",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 5,
              color: Color.fromRGBO(255, 255, 255, 0.4),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a subject.';
              }
              return null;
            },
            onSaved: (String value){
              formData["Subject"] = value;
            },
            textAlign: TextAlign.center,
//            decoration: InputDecoration(
//              hintText: "Subject",
//            ),
          ),
          SizedBox(
            height: SizeConfig.horizontalBlockSize * 6,
          ),
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
            onSaved: (DateTime value){
              formData["Start time"] = Timestamp.fromDate(value);
            },
            validator: (value) {
              if(value == null){
                return 'Please enter a time';
              } else if (value.isBefore(DateTime.now())) {
                return "Please enter a time in the future";
              }else{
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
            onSaved: (DateTime value){
              formData["End time"] = Timestamp.fromDate(value);
            },
            validator: (value) {
              if(value == null){
                return 'Please enter a time';
              } else if (value.isBefore(DateTime.now())) {
                return "Please enter a time in the future";
              }else{
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Firestore.instance.collection('Reminders').add(
        {
          "Subject": formData["Subject"],
          "End": formData["End time"],
          "Start": formData["Start time"],
        },
      );
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(content: Text('Reminder added.')));
      Navigator.pop(context);
    }
  }
}
