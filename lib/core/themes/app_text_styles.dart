import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/utils/app_strings.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/core/utils/get_responsive_font_size.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle ralewayFont18Medium(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.w500,
        fontFamily: AppStrings.ralewayFontFamily,
        color: AppColors.mediumGrey,
      );

  static TextStyle ralewayFont20SemiBold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.w600,
        fontFamily: AppStrings.ralewayFontFamily,
      );

  static TextStyle nunitoFont20Bold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.nunitoFontFamily,
      );

  static TextStyle nunitoFont16Bold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.nunitoFontFamily,
      );

  static TextStyle playfairFont64Bold(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context,
            fontSize: PaddingDimensions.xxxxLarge),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.playfairFontFamily,
      );

  static TextStyle playfairFont32Bold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.xxLarge),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.playfairFontFamily,
      );

  static TextStyle playfairFont24Bold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.xLarge),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.playfairFontFamily,
      );

  static TextStyle playfairFont16Bold(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.bold,
        fontFamily: AppStrings.playfairFontFamily,
      );

  static TextStyle nunitoFont24Regular(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.xLarge),
        fontWeight: FontWeight.w400,
        fontFamily: AppStrings.nunitoFontFamily,
      );

  static TextStyle nunitoFont20Medium(BuildContext context, {Color? color}) =>
      TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.w500,
        fontFamily: AppStrings.nunitoFontFamily,
        color: color ?? AppColors.mediumGrey,
      );

  static TextStyle nunitoFont16Regular(BuildContext context,{Color? color}) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.w400,
        fontFamily: AppStrings.nunitoFontFamily,
        color:color?? AppColors.white,
      );

  static TextStyle nunitoFont20Regular(BuildContext context) => TextStyle(
        fontSize:
            getResponsiveFontSize(context, fontSize: PaddingDimensions.large),
        fontWeight: FontWeight.w400,
        fontFamily: AppStrings.nunitoFontFamily,
      );
}
