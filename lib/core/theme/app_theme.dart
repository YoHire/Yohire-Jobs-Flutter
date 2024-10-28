import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';

class MyTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF194092), // A deep blue color
    hintColor: const Color(0xFF194092),
    scaffoldBackgroundColor: const Color(0xFFfafafa),
    textTheme: TextTheme(
      displayLarge: MyTextStyle.displayLarge,
      displayMedium: MyTextStyle.displayMedium,
      displaySmall: MyTextStyle.displaySmall,
      headlineLarge: MyTextStyle.headLineLarge,
      headlineMedium: MyTextStyle.headLineMedium,
      headlineSmall: MyTextStyle.headLineSmall,
      titleLarge: MyTextStyle.titleLarge,
      titleMedium: MyTextStyle.titleMedium,
      titleSmall: MyTextStyle.titleSmall,
      bodyLarge: MyTextStyle.bodyLarge,
      bodyMedium: MyTextStyle.bodyMedium,
      bodySmall: MyTextStyle.bodySmall,
      labelLarge: MyTextStyle.labelLarge,
      labelMedium: MyTextStyle.labelMedium,
      labelSmall: MyTextStyle.labelSmall,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF194092), // Primary deep blue color
      onPrimary:
          Colors.white, // Text/icons on primary should be white for contrast
      secondary: Color(0xFF2E7D32), // A green for secondary actions
      onSecondary: Colors.white, // Text/icons on secondary should also be white
      error: Color(0xFFD32F2F), // Red for errors
      onError: Colors.white, // White on error color
      surface: Colors.white, // Surface background color (e.g., cards)
      onSurface: Colors.black, // Text/icons on background
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor:
        const Color(0xFF194092), // Keeping the same deep blue color for primary
    hintColor: const Color(0xFF194092),
    scaffoldBackgroundColor: Colors.black, // Dark background
    textTheme: TextTheme(
      displayLarge: MyTextStyle.displayLarge,
      displayMedium: MyTextStyle.displayMedium,
      displaySmall: MyTextStyle.displaySmall,
      headlineLarge: MyTextStyle.headLineLarge,
      headlineMedium: MyTextStyle.headLineMedium,
      headlineSmall: MyTextStyle.headLineSmall,
      titleLarge: MyTextStyle.titleLarge,
      titleMedium: MyTextStyle.titleMedium,
      titleSmall: MyTextStyle.titleSmall,
      bodyLarge: MyTextStyle.bodyLarge,
      bodyMedium: MyTextStyle.bodyMedium,
      bodySmall: MyTextStyle.bodySmall,
      labelLarge: MyTextStyle.labelLarge,
      labelMedium: MyTextStyle.labelMedium,
      labelSmall: MyTextStyle.labelSmall,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(
          0xFF194092), // A lighter blue for primary in dark mode for visibility
      onPrimary: Color.fromARGB(
          255, 255, 255, 255), // Dark text/icons on the lighter blue
      secondary: Color(
          0xFF43A047), // A brighter green for secondary actions in dark mode
      onSecondary: Color(0xFF121212), // Black text/icons on secondary for contrast
      error: Colors.red, // A brighter red for errors in dark mode
      onError: Colors.white, // Black text/icons on error color
      surface: Color(0xFF121212), // Dark surface color for cards and dialogs
      onSurface: Colors.white, // White text/icons on background
    ),
  );
}
