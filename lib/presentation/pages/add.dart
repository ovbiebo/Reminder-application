import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Reminder/presentation/widgets/createReminderCard.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageBodyState createState() {
    return AddPageBodyState();
  }
}

class AddPageBodyState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardKey = GlobalKey<CreateReminderCardState>();
  Map<String, dynamic> formData = {
    "Subject": null,
    "Start time": null,
    "End time": null
  };

  @override
  Widget build(buildContext) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        elevation: 0.0,
        title: Text(
          "   Create",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 6.6,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 5,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _content()),
          FlatButton(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.horizontalBlockSize * 9),
                child: Text(
                  "save",
                  style: questrialStyle.copyWith(
                    fontSize: SizeConfig.horizontalBlockSize * 6.6,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onPressed: () => (submit())? Navigator.pop(context): null,
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: SizeConfig.horizontalBlockSize * 9,
            right: SizeConfig.horizontalBlockSize * 9,
          ),
          child: CreateReminderCard(
            key: _cardKey,
            formData: formData,
          ),
        ),
      ),
    );
  }

  bool submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      formData = _cardKey.currentState.widget.formData;

      Firestore.instance.collection('Reminders').add(
        {
          "Subject": formData["Subject"],
          "End": Timestamp.fromDate(DateTime.now().add(Duration(minutes: 1))),
          "Start": Timestamp.fromDate(DateTime.now().add(Duration(seconds: 20))),
        },
      );
      return true;
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(content: Text('Reminder added.')));
    }
    return false;
  }
}