import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            (size.height * 0.15).vGap,
            Center(
              child: Text(
                '😎 DecorRide',
                style: kH2TextStyle(context),
              ),
            ),
            24.vGap,
            Text(
              "Bring your dream house to life",
              style: context.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            32.vGap,
            CustomElevatedButton(
              text: "CONTINUE WITH EMAIL",
              onPressed: () {
                context.push('/enter_email');
              },
              backgroundColor: context.colorScheme.secondaryContainer,
              foregroundColor: context.colorScheme.onSecondaryContainer,
              leadingIcon: Icons.email,
              leadingIconColor: context.colorScheme.primary,
            ),
            16.vGap,
            CustomElevatedButton(
              text: "CONTINUE WITH GOOGLE",
              onPressed: () {},
              backgroundColor: context.colorScheme.secondaryContainer,
              foregroundColor: context.colorScheme.onSecondaryContainer,
              leadingIcon: Icons.facebook_outlined,
              leadingIconColor: context.colorScheme.primary,
            ),
            32.vGap,
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Can't find your sign in option? "),
                  TextSpan(
                    text: "Click Here",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
