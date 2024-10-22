import 'package:flutter/material.dart';

class Dimensions {
  Dimensions._();
  static late bool isMobile;

  static const double xSmall = 6;
  static const double small = 8;
  static const double normal = 10;
  static const double large = 12;
  static const double xLarge = 14;
  static const double xxLarge = 16;
  static const double xxxLarge = 18;
  static const double xxxxLarge = 20;
  static const double xxxxxLarge = 22;

  static const double smallDisplay = 24;
  static const double mediumDisplay = 30;
  static const double largeDisplay = 48;

  static const double buttonHeight = 48;
  static const double buttonMediumHeight = 40;
  static const double buttonMinHeight = 34;

  static const double pickerItemHeight = 30;

  static const double toolbarHeight = kToolbarHeight;

  static const double buttonCornerRadius = 24;

  static EdgeInsetsDirectional pageMargins =
      const EdgeInsetsDirectional.symmetric(
    horizontal: PaddingDimensions.pageHorizontalPadding,
    vertical: PaddingDimensions.pageVerticalPadding,
  );

  static const double spaceBetweenTextFields = 20;

  static const double xSmallRadius = 2.0;
  static const double smallRadius = 4.0;
  static const double regularRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double xLargeRadius = 24.0;
}

class IconDimensions {
  IconDimensions._();

  static const double xxSmall = 14;
  static const double xSmall = 16;
  static const double small = 18;
  static const double normal = 20;
  static const double medium = 24;
  static const double large = 32;
  static const double xLarge = 40;
  static const double xxLarge = 50;
}

class PaddingDimensions {
  PaddingDimensions._();
  static const double xSmall = 4;
  static const double small = 6;
  static const double normal = 8;
  static const double regular = 10;
  static const double medium = 12;
  static const double large = 16;
  static const double xLarge = 24;
  static const double xxLarge = 32;
  static const double xxxLarge = 40;
  static const double xxxxLarge = 48;

  //Page Padding
  static const double pageHorizontalPadding = PaddingDimensions.large;
  static const double pageVerticalPadding = PaddingDimensions.large;
}
