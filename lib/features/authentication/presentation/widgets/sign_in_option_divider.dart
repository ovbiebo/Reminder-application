import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

///Created by Demilade Oladugba on 4/23/2020

class SignInOptionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.white,
            endIndent: SizeConfig.horizontalBlockSize * 3,
            indent: SizeConfig.horizontalBlockSize * 3,
          ),
        ),
        Text(
          "or sign in with",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 5,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.white,
            endIndent: SizeConfig.horizontalBlockSize * 3,
            indent: SizeConfig.horizontalBlockSize * 3,
          ),
        ),
      ],
    );
  }
}
