import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

///Created by Demilade Oladugba on 4/23/2020

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  final Function onPressed;

  const ButtonWidget(
      {Key key, @required this.buttonName, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: questrialStyle.copyWith(
          fontSize: SizeConfig.horizontalBlockSize * 6.6,
          color: Colors.white,
        ),
      ),
    );
  }
}
