import 'package:flutter/material.dart';

class ThemeColor {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkMode ? const Color(0xFF000000) : Colors.white,
      useMaterial3: true,
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(
          isDarkMode ? const Color(0xFF303330) : Colors.grey,
        ),
        thumbColor: MaterialStateProperty.all(const Color(0xFF05B495)),
      ),
      textTheme: Theme.of(context)
          .textTheme
          .copyWith(
            titleSmall:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 11),
          )
          .apply(
            bodyColor: isDarkMode ? Colors.white : Colors.black,
            displayColor: Colors.grey,
          ),
      // primaryColor: isDarkMode ? const Color(0xFF202320) : Colors.white,
      primaryColor: const Color(0xFF05B495),
      indicatorColor: isDarkMode ? Color(0xFF0E1D36) : Color(0xFFCBDCF8),
      hintColor: isDarkMode ? Color(0xFF280C0B) : Color(0xff133762),
      highlightColor: isDarkMode ? Color(0xFF372901) : Color(0xff133762),
      hoverColor: isDarkMode ? Color(0xFF3A3A3B) : Color(0xff133762),
      focusColor: isDarkMode ? Color(0xFF0B2512) : Color(0xff133762),
      disabledColor: Colors.grey,
      cardColor: isDarkMode ? const Color(0xFF303330) : Colors.white,
      canvasColor: isDarkMode ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkMode ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? const Color(0xFF333333) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : const Color(0xFF303330),
        elevation: 0,
        actionsIconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : const Color(0xFF303330),
          size: 32,
          weight: 700,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            isDarkMode ? Colors.white : const Color(0xFF303330),
          ),
          iconSize: MaterialStateProperty.all<double>(32.0),
          iconColor: MaterialStateProperty.all<Color>(
            isDarkMode ? Colors.white : const Color(0xFF303330),
          ),
        ),
      ),

      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        primary: const Color(0xFF05B495),
        primaryContainer: isDarkMode ? const Color(0xFF222222) : Colors.white,
        onPrimaryContainer:
            isDarkMode ? const Color(0xFFF9FBF8) : const Color(0xFF202320),
        secondary: isDarkMode ? const Color(0xFF444444) : Colors.white,
        onSecondary:
            isDarkMode ? const Color(0xFFF9FBF8) : const Color(0xFF202320),
        background: isDarkMode ? const Color(0xFF000000) : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        onPrimary:
            isDarkMode ? const Color(0xFFF9FBF8) : const Color(0xFF202320),
        surface: isDarkMode ? const Color(0xFF333333) : const Color(0xFFE5E5E5),
        onSurface:
            isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF333333),
        tertiary:
            isDarkMode ? const Color(0xFF444444) : const Color(0xFFE5E5E5),
      ),
    );
  }
}
