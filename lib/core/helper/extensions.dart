import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}

extension NullOrEmptyString on String? {
  /// Check if the string is null or empty
  bool get nullOrEmpty => this == null || this == '';
}



extension CheckDarkThemeActivation on BuildContext {
  bool get isDarkModeActive => Theme.of(this).brightness == Brightness.dark;
}
