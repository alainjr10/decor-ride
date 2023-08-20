import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton {
  static Widget outlinedButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool icon = false,
    IconData? iconData,
    required Color color,
    Color? textColor,
    double? width,
    double? height,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderWidth,
    Color? borderColor,
    double? borderRadius,
  }) {
    return SizedBox(
      width: width,
      height: height ?? 40.0,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: textColor ?? color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
            ),
            side: BorderSide(
              color: borderColor ?? color,
              width: borderWidth ?? 1.5,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)),
        child: Row(
          children: [
            icon
                ? Icon(
                    iconData,
                    color: color,
                  )
                : 0.hGap,
            Text(
              text,
              style: context.textTheme.bodyLarge!.copyWith(
                  color: color, fontSize: fontSize, fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
