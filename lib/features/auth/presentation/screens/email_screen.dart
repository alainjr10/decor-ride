import 'package:decor_ride/app/providers/global_providers.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/features/auth/presentation/providers/check_user_email_provider.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterEmailScreen extends HookConsumerWidget {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final checkUserEmailState = ref.watch(checkUserEmailNotifierProvider);
    final isLoading = checkUserEmailState is AsyncLoading<bool>;
    ref.listen<AsyncValue<void>>(
      checkUserEmailNotifierProvider,
      (_, state) => state.whenOrNull(
        data: (_) {
          ref.read(emailProvider.notifier).state = emailController.text;
          // context.go('/enter_password');
          if (checkUserEmailState.value == true) {
            // if user email exists, navigate to next screen with signin param
            context.push('/enter_password/signin');
          } else {
            // if user email exists, navigate to next screen with signup param
            context.push('/enter_password/signup');
          }
        },
        loading: () {},
        error: (e, stackTrace) {
          Fluttertoast.showToast(msg: e.toString());
          // context.showErrorSnackBar(e.toString());
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter email",
              style: kH3TextStyle(context),
            ),
            40.vGap,
            TextFormField(
              controller: emailController,
              // autofocus: true,
              decoration: InputDecoration(
                hintText: "Email",
                labelText: "Email",
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: context.colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
            24.vGap,
            CustomElevatedButton(
              text: "CONTINUE",
              isLoading: isLoading,
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onSecondaryContainer,
              onPressed: () {
                // context.push('/enter_password');
                "email is ${emailController.text}".log();
                ref
                    .read(checkUserEmailNotifierProvider.notifier)
                    .checkUserEmail(emailController.text);
                // unfocus textfield
                FocusScope.of(context).unfocus();
                // .checkUserEmailUseCase(emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
