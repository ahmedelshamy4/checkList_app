
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxTile extends StatelessWidget {
  final bool value;
  final void Function(bool? value)? onChanged;
  final Widget? child;
  final String? title;
  final Widget? subTitle;
  final EdgeInsetsGeometry? paddingInsets;
  final Color? unselectedColor;
  final bool? enabled;

  const CustomCheckBoxTile({
    super.key,
    required this.value,
    this.onChanged,
    this.child,
    this.paddingInsets,
    this.unselectedColor,
    this.subTitle,
    this.title,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: unselectedColor ?? AppColors.mediumGrey,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          disabledColor: AppColors.mediumGrey,
          useMaterial3: false,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          listTileTheme: const ListTileThemeData(
            horizontalTitleGap: 1,
          ),
          checkboxTheme: const CheckboxThemeData(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )),
      child: CheckboxListTile(
        subtitle: subTitle,
        dense: true,
        value: value,
        enabled: enabled,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.primaryColor,
        side: BorderSide(
            color: enabled == false ? AppColors.mediumGrey : AppColors.primaryColor,
            width: 1.5),
        contentPadding: paddingInsets,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        title: title != null
            ? Text(
                title ?? '',
                style:AppTextStyles.nunitoFont20Medium(context)

              )
            : child,
      ),
    );
  }
}
