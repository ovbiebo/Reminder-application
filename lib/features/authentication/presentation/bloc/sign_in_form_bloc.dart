import 'dart:async';
import 'package:Reminder/features/authentication/data/models/email_address.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import './bloc.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccess: none(),
        );
      },
      passwordChanged: null,
      registerWithEmailAndPasswordPressed: null,
      signInWithEmailAndPasswordPressed: null,
      signInWithGooglePressed: null,
    );
  }
}
