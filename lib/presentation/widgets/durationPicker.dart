import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/utils/constants.dart';

Widget DurationPicker() {
  List<int> numbers = List.generate(24, (i) => i+1);
  return Container(
    width: SizeConfig.horizontalBlockSize * 70,
    height: SizeConfig.verticalBlockSize * 28,
    padding: EdgeInsets.only(
      left: SizeConfig.horizontalBlockSize * 7,
      right: SizeConfig.horizontalBlockSize * 4,
    ),
    decoration: cardDecoration.copyWith(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(SizeConfig.horizontalBlockSize * 4))),
    child: GridView.count(
      crossAxisCount: 6,
      shrinkWrap: true,
      children: numbers
          .map(
            (number) => Text(
              number.toString().padLeft(2, '0'),
              style: questrialStyle.copyWith(
                fontSize: SizeConfig.horizontalBlockSize * 5,
                color: Colors.white,
              ),
            ),
          )
          .toList(),
    ),
  );
}
