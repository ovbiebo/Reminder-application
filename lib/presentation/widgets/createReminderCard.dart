import 'package:Reminder/presentation/widgets/contextualMenu.dart';
import 'package:Reminder/presentation/widgets/customToggleButtons.dart';
import 'package:Reminder/presentation/widgets/persistentPage.dart';
import 'package:Reminder/presentation/widgets/durationPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateReminderCard extends StatefulWidget {
  @required
  final Map<String, dynamic> formData;

  const CreateReminderCard({Key key, this.formData}) : super(key: key);

  @override
  CreateReminderCardState createState() {
    return CreateReminderCardState();
  }
}

class CreateReminderCardState extends State<CreateReminderCard> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(
      initialPage: 0,
    );

    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.verticalBlockSize * 1.5,
        bottom: SizeConfig.verticalBlockSize * 1.5,
        left: SizeConfig.horizontalBlockSize * 5,
        right: SizeConfig.horizontalBlockSize * 5,
      ),
      height: SizeConfig.verticalBlockSize * 60,
      decoration: cardDecoration,
      constraints: BoxConstraints(
//      minHeight: SizeConfig.verticalBlockSize * 60,
        maxWidth: SizeConfig.horizontalBlockSize * 82,
      ),
      child: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (page) {
          if (page == 1) {}
        },
        physics: BouncingScrollPhysics(),
        controller: controller,
        children: <Widget>[
          PersistentPage(child: _addFormFields()),
          PersistentPage(child: _addFormTimeFields()),
        ],
      ),
    );
  }

  Widget _addFormFields() {
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

  Widget _addFormTimeFields() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: CustomToggleButtons(
            items: ["S", "M", "T", "W", "T", "F", "S"],
            selections: List.generate(
                7, (i) => (i == DateTime.now().weekday) ? true : false),
            itemConstraints: BoxConstraints.tightFor(
              width: SizeConfig.horizontalBlockSize * 10.0,
              height: SizeConfig.verticalBlockSize * 8.0,
            ),
          ),
        ),
        Center(
          child: TextFormField(
            cursorColor: Colors.white,
            validator: (value) {
              return (value.isEmpty) ? 'Please enter a time.' : null;
            },
            onSaved: (String value) {
              widget.formData["Start"] = value;
            },
            textAlign: TextAlign.center,
            style: largeTextfieldStyle,
            decoration: largeTextfieldDecoration.copyWith(
              hintText: "08:00",
            ),
          ),
        ),
//        DateTimeField(
//          format: DateFormat("HH:mm a"),
//          onShowPicker: (context, currentValue) async {
//            final time = await showTimePicker(
//              context: context,
//              initialTime:
//                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//            );
//            return DateTimeField.convert(time);
//          },
//          onSaved: (DateTime value) {
//            widget.formData["End time"] = value;
//          },
//          validator: (value) {
//            if (value == null) {
//              return 'Please enter a time';
//            } else {
//              return null;
//            }
//          },
//        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ContextualMenu(
            menu: DurationPicker(),
            child: Container(
              padding: EdgeInsets.all(SizeConfig.verticalBlockSize * 3),
              color: Colors.transparent,
              child: Text(
                "For 5 minutes",
                style: questrialStyle.copyWith(
                  decoration: TextDecoration.underline,
                  fontSize: SizeConfig.horizontalBlockSize * 5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
