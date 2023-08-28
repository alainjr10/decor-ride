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
    // focus scope variable
    final FocusScopeNode currentFocus = FocusScope.of(context);

    ref.listen<AsyncValue<bool>>(
      checkUserEmailNotifierProvider,
      (_, state) => state.whenOrNull(
        data: (_) {
          // "Value is ${checkUserEmailState.value}, and state is $state and value is ${state.value}"
          //     .log();
          ref.read(emailProvider.notifier).state = emailController.text;
          if (state.value == true) {
            // if user email exists, navigate to next screen with signin param
            "user email exists".log();
            context.push('/enter_password/signin');
          } else {
            // if user email exists, navigate to next screen with signup param
            "user email does not exist".log();
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
              onPressed: () async {
                "State from email screen before is $checkUserEmailState".log();
                //  FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                await ref
                    .read(checkUserEmailNotifierProvider.notifier)
                    .checkUserEmail(emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
