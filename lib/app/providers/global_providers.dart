import 'package:decor_ride/features/auth/presentation/providers/states/auth_value_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');

final passwordProvider = StateProvider<String>((ref) => '');
final passwordValueProvider = StateProvider<AuthValueFailure>(
    (ref) => const AuthValueFailure.shortPassword(failedValue: ""));

final togglePasswordVisibilityProvider = StateProvider<bool>((ref) => true);

final logoutUserProvider = StateProvider<bool>((ref) => false);
