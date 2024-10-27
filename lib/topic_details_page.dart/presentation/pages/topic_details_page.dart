import 'package:checklist_app/core/custom_widgets/custom_check_box_tile.dart';
import 'package:checklist_app/core/custom_widgets/toast_service.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_cubit.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_state.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/widgets/add_or_edit_topic_dialog.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TopicDetailsPage extends StatelessWidget {
  final TopicEntity topic;
  final String checklistId;

  const TopicDetailsPage(
      {super.key, required this.topic, required this.checklistId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopicDetailsCubit()
        ..getAllDetailsItemsForTopic(
            checklistId: checklistId, topicId: topic.topicId),
      child: _TopicDetailsForm(
        topic: topic,
        checklistId: checklistId,
      ),
    );
  }
}

class _TopicDetailsForm extends StatefulWidget {
  final TopicEntity topic;
  final String checklistId;

  const _TopicDetailsForm(
      {super.key, required this.topic, required this.checklistId});

  @override
  State<_TopicDetailsForm> createState() => _TopicDetailsFormState();
}

class _TopicDetailsFormState extends State<_TopicDetailsForm> {
  List<TopicDetailsEntity> _detailsList = [];

  void _showAddOrEditTopicDialog(BuildContext contxt,
      {TopicDetailsEntity? item}) {
    showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return AddOrEditTopicDialog(
          item: item,
          topicId: widget.topic.topicId,
          checklistId: widget.checklistId,
          onAddDetailsItemForTopicCallback: (topicId, checklistId, details) {
            context.read<TopicDetailsCubit>().addDetailsItemForTopic(
                  topicId: topicId,
                  checklistId: checklistId,
                  details: details,
                );
          },
          onUpdateDetailsItemForTopicCallback:
              (topicId, checklistId, newDetails) {
            context.read<TopicDetailsCubit>().updateDetailsItemForTopic(
                  topicId: topicId,
                  checklistId: checklistId,
                  updatedDetails: newDetails,
                );
          },
        );
      },
    );
  }

  void _showDeleteTopicDialog(BuildContext contxt, String detailsId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              'Are you sure you want to delete?',
              style: AppTextStyles.nunitoFont20Medium(context),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: AppTextStyles.nunitoFont20Bold(context),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Delete',
                  style: AppTextStyles.nunitoFont20Bold(context),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  contxt.read<TopicDetailsCubit>().removeDetailsItemForTopic(
                        checklistId: widget.checklistId,
                        topicId: widget.topic.topicId,
                        detailsId: detailsId,
                      );
                },
              ),
            ]);
      },
    );
  }


  int _calculateTotalSelectedPackages(List<TopicDetailsEntity> detailsList) {
    int totalSelected = 0;
    for (var details in detailsList) {
      totalSelected +=
          details.selectedPackages.where((pkg) => pkg.isSelected).length;
    }
    return totalSelected;
  }

  int _calculateTotalPackages(TopicDetailsEntity item) {
    return item.selectedPackages.length;
  }

  double _calculateOverallProgress() {
    int totalPackages = 0;
    int selectedPackages = 0;

    for (var item in _detailsList) {
      totalPackages += item.selectedPackages.length;
      selectedPackages +=
          item.selectedPackages.where((e) => e.isSelected).length;
    }

    return totalPackages == 0 ? 0.0 : selectedPackages / totalPackages;
  }

  bool _areAllPackagesSelected(TopicDetailsEntity item) {
    return item.selectedPackages.every((pkg) => pkg.isSelected);
  }

  int _completedTopicsCountSelected() {
    int completedTopicsCount = 0;
    for (var topic in _detailsList) {
      if (topic.selectedPackages.every((package) => package.isSelected)) {
        completedTopicsCount++;
      }
    }
    return completedTopicsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<TopicDetailsCubit, TopicDetailsState>(
          listener: (context, state) {
            if (state.getDetailsTopicsState.isSuccess) {
              _detailsList = state.getDetailsTopicsState.data ?? [];
            } else if (state.getDetailsTopicsState.isFailure) {
              print(
                  '=errorMessage=:: ${state.getDetailsTopicsState.failure?.errorMessage.toString()}');
              ToastService().showToast(context, "Failed to fetch topics");
            }
            if (state.addDetailsTopicState.isSuccess) {
              ToastService().showToast(context, "Item added successfully");
            } else if (state.addDetailsTopicState.isFailure) {
              ToastService().showToast(context, "Failed to add details item");
            }
            if (state.removeDetailsTopicState.isSuccess) {
              ToastService().showToast(context, "Item Removed successfully");
            } else if (state.removeDetailsTopicState.isFailure) {
              ToastService().showToast(context, "Failed to remove  item");
            }
            if (state.updateDetailsTopicState.isFailure) {
              ToastService().showToast(context, "Failed to update item");
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                title: Text(
                  widget.topic.name,
                  style: AppTextStyles.nunitoFont20Medium(context,
                      color: AppColors.blackColor),
                ),
              ),
              body: _detailsList.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingDimensions.large,
                              vertical: PaddingDimensions.large),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    value: _calculateOverallProgress(),
                                    backgroundColor:
                                        AppColors.mediumGrey.withOpacity(.1),
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const Gap(PaddingDimensions.large),
                              Text(
                                '${(_calculateOverallProgress() * 100).toStringAsFixed(1)}%',
                                style: AppTextStyles.nunitoFont20Medium(
                                  context,
                                  color: AppColors.redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PaddingDimensions.large,
                            vertical: PaddingDimensions.large,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'TotalSelected: ${_completedTopicsCountSelected()} / Total: ${_detailsList.length}',
                                style: AppTextStyles.nunitoFont16Bold(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            padding: EdgeInsets.zero,
                            itemCount: _detailsList.length,
                            itemBuilder: (context, index) {
                              final item = _detailsList[index];
                              return Container(
                                color: _areAllPackagesSelected(item)
                                    ? AppColors.mediumGrey.withOpacity(.1)
                                    : AppColors.white,
                                child: ListTile(
                                  title: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: PaddingDimensions.normal),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          AppColors.mediumGrey.withOpacity(.1),
                                    ),
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        if (_areAllPackagesSelected(item)) ...[
                                          const Gap(PaddingDimensions.large),
                                          Text(
                                            " ✅",
                                            style: AppTextStyles
                                                .nunitoFont20Medium(context),
                                          ),
                                        ],
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            "🚀 ${item.title}",
                                            style: AppTextStyles
                                                .nunitoFont20Medium(context),
                                          ),
                                        ),
                                        _areAllPackagesSelected(item)
                                            ? const SizedBox.shrink()
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    onPressed: () {
                                                      _showAddOrEditTopicDialog(
                                                          context,
                                                          item: _detailsList[
                                                              index]);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () =>
                                                        _showDeleteTopicDialog(
                                                            context, item.id),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "👉 ${item.description}",
                                        style:
                                            AppTextStyles.nunitoFont16Regular(
                                          context,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      if (item.subDescription != null &&
                                          (item.subDescription?.isNotEmpty ??
                                              false)) ...[
                                        Text(
                                          "👉 ${item.subDescription ?? ''}",
                                          style:
                                              AppTextStyles.nunitoFont16Regular(
                                                  color: AppColors.blackColor,
                                                  context),
                                        ),
                                      ],
                                      const Gap(PaddingDimensions.normal),
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: PaddingDimensions.normal,
                                            horizontal:
                                                PaddingDimensions.normal,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '👇 Packages:',
                                                  style: AppTextStyles
                                                      .ralewayFont20SemiBold(
                                                          context),
                                                ),
                                              ),
                                              Text(
                                                'Selected: ${_calculateTotalSelectedPackages(_detailsList)} / TotalPackages: ${_calculateTotalPackages(item)}',
                                                style: AppTextStyles
                                                    .nunitoFont16Bold(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (item.packages.isNotEmpty)
                                        Wrap(
                                          spacing: 8.0,
                                          runSpacing: 4.0,
                                          children: item.selectedPackages
                                              .map((package) {
                                            return CustomCheckBoxTile(
                                              paddingInsets: EdgeInsets.zero,
                                              value: package.isSelected,
                                              title: package.name,
                                              onChanged: (value) {
                                                if (value == null) return;
                                                package.isSelected = value;
                                                context
                                                    .read<TopicDetailsCubit>()
                                                    .updateDetailsItemForTopic(
                                                      topicId:
                                                          widget.topic.topicId,
                                                      checklistId:
                                                          widget.checklistId,
                                                      updatedDetails: item,
                                                    );
                                                setState(() {});
                                              },
                                            );
                                          }).toList(),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(PaddingDimensions.xxxxLarge),
                      ],
                    )
                  : (state.getDetailsTopicsState.isLoading ||
                          state.addDetailsTopicState.isLoading)
                      ? const SizedBox.shrink()
                      : Center(
                          child: Text(
                          'No Item found',
                          style: AppTextStyles.nunitoFont20Medium(context),
                        )),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showAddOrEditTopicDialog(context, item: null),
                child: const Icon(Icons.add),
              ),
            );
          },
        ),
        BlocBuilder<TopicDetailsCubit, TopicDetailsState>(
          builder: (context, state) {
            if (state.getDetailsTopicsState.isLoading ||
                state.addDetailsTopicState.isLoading) {
              return CustomLoader();
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
