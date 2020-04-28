import 'package:Reminder/core/exceptions/failures/auth_failure.dart';
import 'package:Reminder/features/authentication/data/models/email_address.dart';
import 'package:Reminder/features/authentication/data/models/password.dart';
import 'package:Reminder/features/authentication/domain/repositories/i_auth_facade.dart';
import 'package:dartz/dartz.dart';

///Created by Demilade Oladugba on 4/23/2020

class FireBaseAuthFacade implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {EmailAddress emailAddress, Password password}) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {EmailAddress emailAddress, Password password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
