import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_value_failure.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<AuthValueFailure<T>, T>? get valueObject;

  bool isValid() => valueObject!.isRight();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return "AuthValueObjects{$valueObject}";
  }
}
