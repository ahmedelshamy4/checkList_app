import 'package:checklist_app/core/custom_widgets/my_speed_dial.dart';
import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return SpeedDialFabWidget(
      primaryBackgroundColor: AppColors.primaryColor,
      primaryForegroundColor: AppColors.darkColor,
      primaryElevation: PaddingDimensions.normal,
      secondaryBackgroundColor: AppColors.closeToBlackColor,
      secondaryForegroundColor: AppColors.primaryColor,
      secondaryElevation: PaddingDimensions.normal,
      secondaryIconsList: const [
        Icons.info,
        Icons.tab,
        Icons.add,
      ],
      secondaryIconsOnPress: List.generate(
        AppConstants.headerTitlesKeys.length,
        (index) => () {
          return context.read<AppCubit>().updateSelectedTab(index);
        },
      ),
      secondaryIconsText: List.generate(
        AppConstants.headerTitlesKeys.length,
        (index) {
          return AppConstants.headerTitlesKeys[index];
        },
      ),
    );
  }
}
