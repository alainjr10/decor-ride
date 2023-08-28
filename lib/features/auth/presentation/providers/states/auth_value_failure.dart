import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_failure.freezed.dart';

@freezed
class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.initial() = Initial<T>;

  const factory AuthValueFailure.invalidEmail({required String? failedValue}) =
      InvalidEmail<T>;

  // empty password
  const factory AuthValueFailure.emptyPassword({required String? failedValue}) =
      EmptyPassword<T>;

  const factory AuthValueFailure.shortPassword({required String? failedValue}) =
      ShortPassword<T>;

  const factory AuthValueFailure.noSpecialSymbol(
      {required String? failedValue}) = NoSpecialSymbol<T>;

  const factory AuthValueFailure.noUpperCase({required String? failedValue}) =
      NoUpperCase<T>;

  const factory AuthValueFailure.noNumber({required String? failedValue}) =
      NoNumber<T>;

  const factory AuthValueFailure.validPassword({required String? failedValue}) =
      ValidPassword<T>;
}
