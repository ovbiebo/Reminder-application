import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Created by Demilade Oladugba on 4/22/2020

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInFormBloc(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: BlocBuilder<SignInFormBloc, SignInFormState>(
            builder: (BuildContext context, SignInFormState state) {
              final signInBloc = BlocProvider.of<SignInFormBloc>(context);
              return Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => signInBloc.add(EmailChanged(value)),
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) =>
                        signInBloc.add(PasswordChanged(value)),
                  ),
                  RaisedButton(
                      onPressed: () => signInBloc
                          .add(RegisterWithEmailAndPasswordPressed())),
                  RaisedButton(
                      onPressed: () =>
                          signInBloc.add(SignInWithEmailAndPasswordPressed())),
                  RaisedButton(
                      onPressed: () =>
                          signInBloc.add(SignInWithGooglePressed())),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
