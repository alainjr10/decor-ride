import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EnterEmailScreen extends ConsumerWidget {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
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
              autofocus: true,
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
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onSecondaryContainer,
              onPressed: () {
                context.push('/enter_password');
              },
            ),
          ],
        ),
      ),
    );
  }
}
