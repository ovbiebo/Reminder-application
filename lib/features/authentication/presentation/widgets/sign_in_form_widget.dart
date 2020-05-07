import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:Reminder/features/authentication/presentation/widgets/widgets.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccess.fold(
          () => null,
          (either) => either.fold((failure) {
            FlushbarHelper.createError(
              message: failure.map(
                cancelledByUser: (_) => 'Cancelled',
                serverError: (_) => 'Server error',
                emailAlreadyInUse: (_) => 'Email already in use',
                invalidEmailAndPasswordCombination: (_) =>
                    'Invalid email and password combination',
              ),
            ).show(context);
          }, (r) => null),
        );
      },
      builder: (context, state) {
        return state.isSubmitting
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Form(
                autovalidate: state.showErrorMessages,
                child: Column(
                  children: <Widget>[
                    CardWidget(
                      widget: BlocBuilder<SignInFormBloc, SignInFormState>(
                        builder: (context, state) {
                          return Column(
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
                                onChanged: (value) => context
                                    .bloc<SignInFormBloc>()
                                    .add(EmailChanged(value)),
                                validator: (value) {
                                  return context
                                      .bloc<SignInFormBloc>()
                                      .state
                                      .emailAddress
                                      .value
                                      .fold(
                                          (l) => l.maybeMap(
                                                orElse: () => null,
                                                invalidEmail: (_) =>
                                                    "Email Invallid",
                                              ),
                                          (r) => null);
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                cursorColor: Colors.white,
                                textAlign: TextAlign.center,
                                style: largeTextfieldStyle,
                                decoration: largeTextfieldDecoration.copyWith(
                                  hintText: "Password",
                                ),
                                onChanged: (value) => context
                                    .bloc<SignInFormBloc>()
                                    .add(PasswordChanged(value)),
                                validator: (value) {
                                  return context
                                      .bloc<SignInFormBloc>()
                                      .state
                                      .password
                                      .value
                                      .fold(
                                          (l) => l.maybeMap(
                                                orElse: () => null,
                                                shortPassword: (_) =>
                                                    "Password too short",
                                              ),
                                          (r) => null);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonWidget(
                          buttonName: "signin",
                          onPressed: () => signInWithEmailAndPassword(context),
                        ),
                        ButtonWidget(
                          buttonName: "register",
                          onPressed: () =>
                              registerWithEmailAndPassword(context),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.horizontalBlockSize * 15),
                    SignInOptionDivider(),
                    SizedBox(height: SizeConfig.horizontalBlockSize * 5),
                    ButtonWidget(
                      buttonName: "google",
                      onPressed: () => signInWithGoogle(context),
                    ),
                  ],
                ),
              );
      },
    );
  }

  void signInWithEmailAndPassword(BuildContext context) {
    context.bloc<SignInFormBloc>().add(SignInWithEmailAndPasswordPressed());
  }

  void registerWithEmailAndPassword(BuildContext context) {
    context.bloc<SignInFormBloc>().add(RegisterWithEmailAndPasswordPressed());
  }

  void signInWithGoogle(BuildContext context) {
    context.bloc<SignInFormBloc>().add(SignInWithGooglePressed());
  }
}
