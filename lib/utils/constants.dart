import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

kH3TextStyle(BuildContext context) => context.textTheme.headlineSmall!.copyWith(
      color: context.colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );
kH2TextStyle(BuildContext context) => context.textTheme.headlineLarge!.copyWith(
      color: context.colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );
