import 'package:Reminder/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:Reminder/Components/countdownController.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Widget Clock(DateTime startTime, DateTime endTime) {
  return Expanded(
      child: SetClock(startTime, endTime)
  );
}

Widget SetClock(DateTime startTime, DateTime endTime){
  if(startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now())){
    return Countdown(endTime.difference(startTime), DateTime.now().difference(startTime));
  }else if(endTime.isBefore(DateTime.now())){
    return Ended();
  }else{
    return AnalogClock(startTime);
  }
}

Widget Countdown(Duration period, Duration elapsed) {
  return FlareActor(
    "assets/ReminderTimer.flr",
    alignment: Alignment.center,
    fit: BoxFit.contain,
    color: Colors.green,
    animation: "countdown",
    controller: CountdownController(period, elapsed.inSeconds/period.inSeconds),
  );
}

Widget Ended(){
  return FlareActor(
    "assets/ReminderTimer.flr",
    alignment: Alignment.center,
    fit: BoxFit.contain,
    color: Color.fromRGBO(22, 22, 22, 1),
    animation: "idle",
  );
}

Widget AnalogClock(DateTime dateTime) {
  return Stack(
    children: <Widget>[
      FlareActor(
        "assets/ReminderTimer.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        color: Color.fromRGBO(22, 22, 22, 1),
        animation: "idle",
      ),
      Center(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(0.0, SizeConfig.horizontalBlockSize * 7, 0.0)
            ..rotateZ(pi + (pi * 2 * dateTime.minute / 60)),
          child: Container(
            color: Colors.white,
            height: SizeConfig.horizontalBlockSize * 14,
            width: SizeConfig.horizontalBlockSize * 0.5,
          ),
        ),
      ),
      Center(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(0.0, SizeConfig.horizontalBlockSize * 4.5, 0.0)
            ..rotateZ(pi + (pi * 2 * dateTime.hour / 12)),
          child: Container(
            color: Colors.white,
            height: SizeConfig.horizontalBlockSize * 9,
            width: SizeConfig.horizontalBlockSize * 0.5,
          ),
        ),
      ),
    ],
  );
}