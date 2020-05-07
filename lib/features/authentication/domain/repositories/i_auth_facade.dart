import 'package:Reminder/core/exceptions/failures/auth_failure.dart';
import 'package:Reminder/features/authentication/data/models/email_address.dart';
import 'package:Reminder/features/authentication/data/models/password.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

///Created by Demilade Oladugba on 4/22/2020

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Stream<FirebaseUser> get user; 

  Future<Either<AuthFailure, FirebaseUser>> get userCurrent; 

  Future<Either<AuthFailure, Unit>> signOut();
}
