import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/providers/global_providers.dart';
import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_value_failure.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final checkValidPasswordNotifierProvider =
    StateNotifierProvider<CheckValidPasswordNotifier, AuthValueFailure>((ref) {
  final password = ref.watch(passwordProvider);
  return CheckValidPasswordNotifier(password: password);
});

class CheckValidPasswordNotifier extends StateNotifier<AuthValueFailure> {
  CheckValidPasswordNotifier({required this.password})
      : super(const AuthValueFailure.shortPassword(failedValue: ""));
  final String password;

  Either<AuthValueFailure<String>, String> checkPasswordValidity(
      {required String? password}) {
    // state = const AuthValueFailure.noUpperCase(failedValue: "");
    "Entered check password visibility block".log();
    final hasMinLength = password!.length > 6;
    final hasUppercase = password.contains(RegExp("[A-Z]"));
    final hasDigits = password.contains(RegExp("[0-9]"));
    final hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasMinLength) {
      state = AuthValueFailure.shortPassword(failedValue: password);
      return left(
        AuthValueFailure.shortPassword(failedValue: password),
      );
    } else if (!hasUppercase) {
      state = AuthValueFailure.noUpperCase(failedValue: password);
      return left(
        AuthValueFailure.noUpperCase(failedValue: password),
      );
    } else if (!hasDigits) {
      state = AuthValueFailure.noNumber(failedValue: password);
      return left(
        AuthValueFailure.noNumber(failedValue: password),
      );
    } else if (!hasSpecialCharacters) {
      state = AuthValueFailure.noSpecialSymbol(failedValue: password);
      return left(
        AuthValueFailure.noSpecialSymbol(failedValue: password),
      );
    } else {
      state = const AuthValueFailure.validPassword(failedValue: "");
      return right(password);
    }
  }
}
