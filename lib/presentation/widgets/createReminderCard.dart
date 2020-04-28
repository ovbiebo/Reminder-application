import 'package:Reminder/presentation/widgets/persistentPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

import 'add_form_field_widget.dart';
import 'add_form_time_fields_widget.dart';

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
          PersistentPage(child: AddFormField(formData: widget.formData)),
          PersistentPage(child: AddFormTimeField(formData: widget.formData)),
        ],
      ),
    );
  }
}
