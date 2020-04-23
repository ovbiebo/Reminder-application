import 'package:Reminder/features/authentication/presentation/widgets/card_widget.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/cupertino.dart';
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
            cardWidget(
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: null,
                  child: Text(
                    "signin",
                    style: questrialStyle.copyWith(
                      fontSize: SizeConfig.horizontalBlockSize * 6.6,
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: null,
                  child: Text(
                    "register",
                    style: questrialStyle.copyWith(
                      fontSize: SizeConfig.horizontalBlockSize * 6.6,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.horizontalBlockSize * 15),
            Row(
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
            ),
            SizedBox(height: SizeConfig.horizontalBlockSize * 5),
            FlatButton(
              onPressed: null,
              child: Text(
                "google",
                style: questrialStyle.copyWith(
                  fontSize: SizeConfig.horizontalBlockSize * 6.6,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
