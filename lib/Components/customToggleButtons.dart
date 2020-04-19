import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/utils/constants.dart';

class CustomToggleButtons extends StatefulWidget {
  final List<String> items;
  final List<bool> selections;
  final BoxConstraints itemConstraints;

  const CustomToggleButtons ({ Key key, this.items , this.itemConstraints, this.selections}): super(key: key);

  @override
  CustomToggleButtonsState createState() {
    return CustomToggleButtonsState();
  }
}

class CustomToggleButtonsState extends State<CustomToggleButtons> {

  @override
  Widget build(BuildContext context) {
    return CustomToggleButtons();
  }

  Widget CustomToggleButtons() {
    return ToggleButtons(
      constraints: widget.itemConstraints,
      fillColor: Colors.transparent,
      color: Color.fromRGBO(255, 255, 255, 0.4),
      renderBorder: false,
      focusColor: Colors.transparent,
      borderWidth: SizeConfig.horizontalBlockSize * 5,
      selectedColor: Colors.white,
      children: widget.items
          .map(
            (weekday) => Text(
              weekday,
              style: questrialStyle.copyWith(
                fontSize: SizeConfig.horizontalBlockSize * 5,
              ),
            ),
          )
          .toList(),
      onPressed: (index) {
        setState(
          () {
            for (int buttonIndex = 0;
                buttonIndex < widget.selections.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                widget.selections[buttonIndex] = true;
              } else {
                widget.selections[buttonIndex] = false;
              }
            }
          },
        );
      },
      isSelected: widget.selections,
    );
  }
}
