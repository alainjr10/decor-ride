import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/core/auth_value_object.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_value_failure.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_value_validators.dart';

class EmailAddress extends ValueObject<String> {
  factory EmailAddress({String? email}) {
    return EmailAddress._(validateEmailAddress(email: email));
  }

  const EmailAddress._(this.valueObject);

  @override
  final Either<AuthValueFailure<String>, String>? valueObject;
}

class Password extends ValueObject<String> {
  factory Password({String? password}) {
    return Password._(validatePassword(password: password));
  }

  const Password._(this.valueObject);

  @override
  final Either<AuthValueFailure<String>, String>? valueObject;
}
