import 'dart:async';
import 'package:Reminder/core/exceptions/failures/auth_failure.dart';
import 'package:Reminder/features/authentication/data/models/email_address.dart';
import 'package:Reminder/features/authentication/data/models/password.dart';
import 'package:Reminder/features/authentication/domain/repositories/i_auth_facade.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {

//  final IAuthFacade _authFacade;
//
//  SignInFormBloc(this._authFacade);

  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        print(e.emailStr);
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccess: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccess: none(),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
//          _authFacade.registerWithEmailAndPassword,
        );
      },
      signInWithEmailAndPasswordPressed: null,
      signInWithGooglePressed: null,
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
//    Future<Either<AuthFailure, Unit>> Function({
//      @required EmailAddress emailAddress,
//      @required Password password,
//    })
//        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccess: none(),
      );

//      failureOrSuccess = await forwardedCall(
//        emailAddress: state.emailAddress,
//        password: state.password,
//      );
    }
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccess: optionOf(failureOrSuccess),
    );
  }
}
