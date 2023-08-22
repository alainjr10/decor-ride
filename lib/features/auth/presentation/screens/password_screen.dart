import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EnterPasswordScreen extends ConsumerWidget {
  const EnterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set password to sign up",
              style: kH3TextStyle(context),
            ),
            24.vGap,
            Text(
              "njokomalain@gmail.com",
              style: context.textTheme.bodySmall,
            ),
            32.vGap,
            TextFormField(
              controller: passwordController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Password*",
                labelText: "Password*",
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
