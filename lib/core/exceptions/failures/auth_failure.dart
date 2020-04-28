import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

///Created by Demilade Oladugba on 4/22/2020

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser() = CancelledByUser;

  const factory AuthFailure.serverError() = ServerError;

  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;

  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination;
}
