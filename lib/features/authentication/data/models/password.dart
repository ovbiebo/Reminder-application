import 'package:Reminder/core/exceptions/failures/failure.dart';
import 'package:Reminder/core/model/value_objects.dart';
import 'package:dartz/dartz.dart';

import 'auth_validator.dart';

///Created by Demilade Oladugba on 4/22/2020

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}