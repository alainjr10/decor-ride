import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomElevatedButton extends ConsumerWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.leadingIconColor,
    this.leadingIconSize = 24,
  });
  final String text;
  final VoidCallback onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color? leadingIconColor;
  final double leadingIconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? backgroundColor == null
                ? context.colorScheme.primary.withOpacity(0.7)
                : backgroundColor!.withOpacity(0.7)
            : backgroundColor ?? context.colorScheme.primary,
        foregroundColor: foregroundColor ?? context.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fixedSize: Size(width ?? size.width, height ?? 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: leadingIcon == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          if (leadingIcon != null)
            Icon(
              leadingIcon,
              color: leadingIconColor ?? foregroundColor,
            ),
          if (leadingIcon != null) 8.hGap,
          if (isLoading)
            SizedBox(
              child: SpinKitThreeBounce(
                size: 24,
                color: foregroundColor ??
                    textColor ??
                    context.colorScheme.onSecondaryContainer,
              ),
            )
          else
            Text(
              text,
              style: TextStyle(
                color: foregroundColor ??
                    textColor ??
                    context.colorScheme.onSecondaryContainer,
              ),
            ),
          if (trailingIcon != null) 8.hGap,
          trailingIcon == null
              ? const SizedBox.shrink()
              : Icon(
                  trailingIcon,
                  color: foregroundColor,
                ),
        ],
      ),
    );
  }
}
