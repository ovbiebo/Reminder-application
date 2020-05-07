import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:Reminder/presentation/widgets/reminder_list_widget.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Created by Demilade Oladugba on 4/19/2020

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: FlatButton(
          onPressed: () {},
          child: Text(
            "   Reminders",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 6.6,
              color: Colors.white,
            ),
          ),
//          onPressed: (){Navigator.of(context).pushNamed("Add");},
        ),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.filter_list),
//            onPressed: () {},
//          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
               BlocProvider.of<SignInFormBloc>(context).add(SignOutPressed());
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("Add");
            },
          ),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 5,
          ),
        ],
      ),
      body: RemindersList(),
    );
  }
}
