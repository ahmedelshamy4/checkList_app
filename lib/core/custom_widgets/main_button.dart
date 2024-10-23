import 'package:checklist_app/core/themes/app_colors.dart';
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
    this.borderColor = Colors.blue, // Use AppColors.primaryColor in your project
    this.borderWidth = 1,
    this.isLoading = false, // Added isLoading flag
    this.loadingColor = Colors.white, // Optional loading spinner color
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
  final bool isLoading; // New isLoading flag
  final Color loadingColor; // New loading spinner color

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? _backgroundColor(context),
        borderRadius: BorderRadiusDirectional.circular(
          borderRadius ?? 12, // Replace with PaddingDimensions.large in your project
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
              horizontal: 16, // Replace with PaddingDimensions.xxLarge in your project
              vertical: 12, // Replace with PaddingDimensions.large in your project
            ),
        onPressed: isLoading ? null : onPressed, // Disable onPressed if loading
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(
            borderRadius ?? 12, // Replace with PaddingDimensions.large in your project
          ),
        ),
        child: isLoading
            ? _buildLoadingIndicator() // Show loading spinner
            : child ?? _buildButtonText(context), // Show text or custom child
      ),
    );
  }

  // Builds the loading spinner
  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 24, // Size of the loading spinner
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.0, // Thickness of the spinner
        valueColor: AlwaysStoppedAnimation<Color>(loadingColor), // Spinner color
      ),
    );
  }

  // Builds the button text
  Widget _buildButtonText(BuildContext context) {
    return Text(
      text!,
      style: textStyle ??
          TextStyle(
            fontSize: fontSize ?? 20,
            color: isOutlined ? Colors.blue : textColor ?? Colors.white, // Replace Colors.blue with AppColors.primaryColor
          ),
    );
  }

  // Determines the background color
  Color _backgroundColor(BuildContext context) {
    return isOutlined
        ? Colors.white // Replace with _outlinedBackgroundColor(context) in your project
        : AppColors.mediumGrey;  // Replace with AppColors.primaryColor in your project
  }
}
