import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/core/utils/get_responsive_font_size.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.boxShadow,
    this.width,
    this.height,
    this.padding,
    this.border,
    this.isOutlined = false,
    this.fontSize,
    this.margin,
    this.borderColor = AppColors.primaryColor,
    this.borderWidth = 1,
  });

  final String? text;
  final Widget? child;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onPressed;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final bool isOutlined;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? _backgroundColor(context),
        borderRadius: BorderRadiusDirectional.circular(
          borderRadius ?? PaddingDimensions.large,
        ),
        boxShadow: boxShadow,
        border: isOutlined
            ? Border.all(
                color: borderColor,
                width: borderWidth,
              )
            : border,
      ),
      child: MaterialButton(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: PaddingDimensions.xxLarge,
              vertical: PaddingDimensions.large,
            ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(
            borderRadius ?? PaddingDimensions.large,
          ),
        ),
        child: child ??
            Text(
              text!,
              style: textStyle ??
                  AppTextStyles.nunitoFont20Medium(context).copyWith(
                    fontSize: getResponsiveFontSize(context,
                        fontSize: fontSize ?? 20),
                    color: isOutlined
                        ? AppColors.primaryColor
                        : textColor ?? Colors.white,
                  ),
            ),
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    return isOutlined
        ? _outlinedBackgroundColor(context)
        : AppColors.primaryColor;
  }

  Color _outlinedBackgroundColor(BuildContext context) =>
      (AppColors.white);
}
