import 'package:checklist_app/core/custom_widgets/app_text_field_input.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/presentation/manager/checklist_cubit.dart';
import 'package:checklist_app/home/presentation/manager/checklist_state.dart';
import 'package:checklist_app/home/presentation/widgets/build_reorderable_check_list_item.dart';
import 'package:checklist_app/home/presentation/widgets/tips_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MainChecklistPage extends StatelessWidget {
  const MainChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChecklistCubit()..loadChecklistItems(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checklist App',
            style: AppTextStyles.nunitoFont20Medium(context,color: AppColors.blackColor),
          ),
        ),
        body: Column(
          children: [
            const Gap(PaddingDimensions.large),
            Text("❇️ Planning and Research ❇️", style: AppTextStyles.playfairFont24Bold(context)),
            TipsCarouselWidget(),
            const Expanded(child: _ChecklistBody()),
          ],
        ),
      ),
    );
  }
}

class _ChecklistBody extends StatefulWidget {
  const _ChecklistBody({super.key});

  @override
  State<_ChecklistBody> createState() => _ChecklistBodyState();
}

class _ChecklistBodyState extends State<_ChecklistBody> {
  final _addChecklistTopicController = TextEditingController();

  void _onSuffixIconPressed() {
    if (_addChecklistTopicController.text.isNotEmpty) {
      context.read<ChecklistCubit>().addChecklistNewItem(
            ChecklistItem(
              id: DateTime.now().toString(),
              name: _addChecklistTopicController.text,

            ),
          );
      _addChecklistTopicController.clear();
    }
  }


  @override
  void dispose() {
    _addChecklistTopicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: _addChecklistTopicController,
                hintText: "Add new checklist topic",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _onSuffixIconPressed,
                ),
              ),
              Expanded(
                child: BlocBuilder<ChecklistCubit, ChecklistState>(
                  builder: (context, state) {
                    if (state.getChecklistItemsState.isFailure) {
                      return Center(
                        child: Text(
                          state.getChecklistItemsState.failure?.errorMessage ??
                              '',
                          style: AppTextStyles.playfairFont24Bold(context),
                        ),
                      );
                    } else if (state.getChecklistItemsState.isSuccess) {
                      final checklist = state.getChecklistItemsState.data;
                      if (checklist != null) {
                        return checklist.isNotEmpty
                            ? BuildReorderableCheckListItem(checklistItems: checklist)
                            : Center(
                                child: Text(
                                  "No Checklist Items",
                                  style:
                                      AppTextStyles.playfairFont24Bold(context),
                                ),
                              );
                      }
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ChecklistCubit, ChecklistState>(
          builder: (context, state) {
            if (state.addChecklistItemState.isLoading ||
                state.getChecklistItemsState.isLoading ||
                state.deleteChecklistItemState.isLoading) {
              return Center(
                child: CustomLoader(),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
