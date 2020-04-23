import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

///Created by Demilade Oladugba on 4/23/2020

Widget cardWidget({Widget widget}) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      padding: cardPadding,
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.verticalBlockSize * 2,
      ),
      width: SizeConfig.horizontalBlockSize * 82,
      height: SizeConfig.verticalBlockSize * 30,
      decoration: cardDecoration,
      child: widget,
    ),
  );
}
