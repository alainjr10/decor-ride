import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/domain/use_cases/auth_value_objects.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';

part 'auth_states.freezed.dart';

// @freezed
// class AuthStates with _$AuthStates {
//   const factory AuthStates.initial() = _Initial;
//   const factory AuthStates.loading() = _Loading;
//   const factory AuthStates.success() = _Success;
//   const factory AuthStates.authenticated({required UserModel user}) =
//       _Authenticated;
//   const factory AuthStates.error(String message) = _Error;
// }

@freezed
class AuthStates with _$AuthStates {
  const factory AuthStates({
    required EmailAddress emailAddress,
    required Password password,
    required bool isSubmitting,
    required bool showError,
    required bool authSuccess,
    required Option<Either<AuthFailures, Unit>> authFailureOrSuccess,
  }) = _AuthStates;

  factory AuthStates.initial() => AuthStates(
      emailAddress: EmailAddress(email: ""),
      password: Password(password: ""),
      showError: false,
      isSubmitting: false,
      authSuccess: false,
      authFailureOrSuccess: none());
}
