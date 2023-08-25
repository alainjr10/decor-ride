import 'package:decor_ride/app/providers/global_providers.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterPasswordScreen extends HookConsumerWidget {
  const EnterPasswordScreen({
    super.key,
    required this.authType,
  });
  final String authType; // signup or signin

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              authType == "signup"
                  ? "Set password to sign up"
                  : "Enter password to sign in",
              style: kH3TextStyle(context),
            ),
            16.vGap,
            Text(
              ref.watch(emailProvider),
              style: context.textTheme.bodyMedium,
            ),
            16.vGap,
            TextFormField(
              controller: passwordController,
              autofocus: true,
              obscureText: ref.watch(togglePasswordVisibilityProvider),
              decoration: InputDecoration(
                hintText: "Password*",
                labelText: "Password*",
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: context.colorScheme.secondaryContainer,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    ref
                        .read(togglePasswordVisibilityProvider.notifier)
                        .update((state) => !state);
                  },
                  icon: Icon(
                    !ref.watch(togglePasswordVisibilityProvider)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: context.colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
            4.vGap,
            authType == "signup"
                ? Text(
                    "Use 8 or more charecters with a mix of letters, numbers & symbols",
                    style: context.textTheme.bodySmall,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password?",
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
            24.vGap,
            CustomElevatedButton(
              text: "SIGN UP",
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onSecondaryContainer,
              onPressed: () {
                context.push('/personal_details');
              },
            ),
          ],
        ),
      ),
    );
  }
}
