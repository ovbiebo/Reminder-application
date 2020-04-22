import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

///Created by Demilade Oladugba on 4/22/2020

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    @required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    @required T failedValue,
  }) = ShortPassword<T>;
}
