import '../widgets/widgets.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

///Created by Demilade Oladugba on 4/22/2020

class SignInPage extends StatelessWidget {
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
      body: Form(
        child: Column(
          children: <Widget>[
            CardWidget(
                widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  style: largeTextfieldStyle,
                  decoration: largeTextfieldDecoration.copyWith(
                    hintText: "Email address",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  style: largeTextfieldStyle,
                  decoration: largeTextfieldDecoration.copyWith(
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonWidget(
                  buttonName: "signin",
                  onPressed: null,
                ),
                ButtonWidget(
                  buttonName: "register",
                  onPressed: null,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.horizontalBlockSize * 15),
            SignInOptionDivider(),
            SizedBox(height: SizeConfig.horizontalBlockSize * 5),
            ButtonWidget(
              buttonName: "google",
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
