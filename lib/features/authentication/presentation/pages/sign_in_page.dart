import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

///Created by Demilade Oladugba on 4/22/2020

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: Container(
          padding: EdgeInsets.only(left: SizeConfig.horizontalBlockSize * 8.6),
          child: Text(
            "SignIn",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 6.6,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      body: SignInForm(),
    );
  }
}
