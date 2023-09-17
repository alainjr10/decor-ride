import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/domain/entities/signin_user_entity.dart';
import 'package:decor_ride/features/auth/domain/use_cases/auth_value_objects.dart';
import 'package:decor_ride/features/auth/domain/use_cases/register_usecase.dart';
import 'package:decor_ride/features/auth/domain/use_cases/signin_usecases.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_failures.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthStates>((ref) {
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final signInUseCase = ref.watch(signInUseCaseProvider);
  return AuthNotifier(
      registerUseCase: registerUseCase, signInUseCase: signInUseCase);
});

class AuthNotifier extends StateNotifier<AuthStates> {
  AuthNotifier({required this.registerUseCase, required this.signInUseCase})
      : super(AuthStates.initial());

  final RegisterUseCase registerUseCase;
  final SignInUseCase signInUseCase;

  Future<void> registerUserWithEmailAndPassword(
      {required CreateUserEntity createUserEntity}) async {
    EmailAddress emailAddress = EmailAddress(email: createUserEntity.email);
    Password password = Password(password: createUserEntity.password);
    state = state.copyWith(
        isSubmitting: true,
        emailAddress: emailAddress,
        password: password,
        authFailureOrSuccess: none());

    try {
      await registerUseCase(createUserEntity);
      // await Future.delayed(const Duration(seconds: 3));
      state = state.copyWith(
          isSubmitting: false,
          showError: false,
          authSuccess: true,
          authFailureOrSuccess: none());
    } catch (e, stackTrace) {
      "error registering user: $e, with stacktrace: $stackTrace".log();
      state = state.copyWith(
          isSubmitting: false,
          showError: true,
          authSuccess: false,
          authFailureOrSuccess: some(left(const AuthFailures.serverError())));
    }
  }

  Future<void> signInUser({required SigninUserEntity signinUserEntity}) async {
    EmailAddress emailAddress = EmailAddress(email: signinUserEntity.email);
    Password password = Password(password: signinUserEntity.password);
    state = state.copyWith(
        isSubmitting: true,
        emailAddress: emailAddress,
        password: password,
        authFailureOrSuccess: none());

    try {
      final response = await signInUseCase(signinUserEntity);
      // await Future.delayed(const Duration(seconds: 3));
      state = response.fold(
        (left) => state.copyWith(
            isSubmitting: false,
            showError: true,
            authSuccess: false,
            errorMessage: left.toString(),
            authFailureOrSuccess: none()),
        (right) => state.copyWith(
            isSubmitting: false,
            showError: false,
            authSuccess: true,
            authFailureOrSuccess: none()),
      );
      "response is $response \n".log();
      "and state is $state \n".log();
    } catch (e, stackTrace) {
      "error signing in user: $e, with stacktrace: $stackTrace".log();
      state = state.copyWith(
          isSubmitting: false,
          showError: true,
          authSuccess: false,
          authFailureOrSuccess: some(left(const AuthFailures.serverError())));
    }
  }
}
