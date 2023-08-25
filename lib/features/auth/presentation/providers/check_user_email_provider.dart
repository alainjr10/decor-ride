import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/auth/domain/use_cases/check_user_email_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkUserEmailNotifierProvider =
    StateNotifierProvider.autoDispose<CheckUserEmailNotifier, AsyncValue<bool>>(
        (ref) {
  "entering check user email notifier provider".log();
  final checkUserEmailUseCase = ref.watch(checkUserEmailUseCaseProvider);
  return CheckUserEmailNotifier(checkUserEmailUseCase: checkUserEmailUseCase);
});

class CheckUserEmailNotifier extends StateNotifier<AsyncValue<bool>> {
  final CheckUserEmailUseCase checkUserEmailUseCase;
  CheckUserEmailNotifier({required this.checkUserEmailUseCase})
      : super(const AsyncValue.data(false));

  Future<void> checkUserEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      "about to check user email".log();
      Future.delayed(const Duration(seconds: 2));
      final result = await checkUserEmailUseCase(email);
      state = AsyncValue.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
