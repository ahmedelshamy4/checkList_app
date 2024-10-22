import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;
  final TextStyle? style;

  const AppTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 1,
      obscureText: obscureText,
      maxLength: null,
      style: style ?? AppTextStyles.nunitoFont16Bold(context),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.large,
          vertical: PaddingDimensions.normal,
        ),
      ),
    );
  }
}
