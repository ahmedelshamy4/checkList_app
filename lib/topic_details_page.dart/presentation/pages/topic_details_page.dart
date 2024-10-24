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

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  void _initializeState() {
    if (_detailsList.isNotEmpty) {
      for (var detail in _detailsList) {
        if (detail.selectedPackages.isEmpty) {
          print('_initializeState${detail.packages.length}');
          // Initialize selectedPackages with false if not already set
          // detail.selectedPackages =
          //     List.generate(detail.packages.length, (_) => false);
        }
      }
    }
  }

  // void _updateProgress(TopicDetailsEntity entity) {
  //   final selectedCount =
  //       entity.selectedPackages.where((isSelected) => isSelected).length;
  //   final totalPackages = entity.selectedPackages.length;
  //   setState(() {
  //     entity.progress =
  //         totalPackages > 0 ? (selectedCount / totalPackages) : 0.0;
  //   });
  // }

  // void _updateProgress(TopicDetailsEntity item) {
  //   int total = item.packages.length;
  //   int selected = item.selectedPackages.where((selected) => selected).length;
  //   item.progress = selected / total;
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<TopicDetailsCubit, TopicDetailsState>(
          listener: (context, state) {
            if (state.getDetailsTopicsState.isSuccess) {
              _detailsList = state.getDetailsTopicsState.data ?? [];
              _initializeState();
            } else if (state.getDetailsTopicsState.isFailure) {
              print('=errorMessage=:: ${state.getDetailsTopicsState.failure?.errorMessage.toString()}');
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
            if (state.updateDetailsTopicState.isSuccess) {
              ToastService().showToast(context, "Item Updated successfully");
            } else if (state.updateDetailsTopicState.isFailure) {
              ToastService().showToast(context, "Failed to update item");
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.topic.name,
                  style: AppTextStyles.nunitoFont20Medium(context),
                ),
              ),
              body: _detailsList.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        // Row for Total Count and Selected Checked
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: ${_detailsList.length}',
                                style:
                                    AppTextStyles.nunitoFont20Medium(context),
                              ),
                              // Text(
                              //   'Selected: ${_detailsList.where((item) => item.isSelected).length}',
                              //   style:
                              //       AppTextStyles.nunitoFont20Medium(context),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: _detailsList.length,
                            itemBuilder: (context, index) {
                              final item = _detailsList[index];
                              return ListTile(
                                title: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: PaddingDimensions.normal),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.mediumGrey.withOpacity(.1),
                                  ),
                                  // color: Colors.red,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          item.title,
                                          style:
                                              AppTextStyles.nunitoFont20Medium(
                                                  context),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              _showAddOrEditTopicDialog(context,
                                                  item: _detailsList[index]);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.description,
                                      style: AppTextStyles.nunitoFont16Regular(
                                        context,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    if (item.subDescription != null &&
                                        (item.subDescription?.isNotEmpty ??
                                            false)) ...[
                                      Text(
                                        item.subDescription ?? '',
                                        style:
                                            AppTextStyles.nunitoFont16Regular(
                                                color: AppColors.blackColor,
                                                context),
                                      ),
                                    ],
                                    const Gap(PaddingDimensions.normal),
                                    Text(
                                      'Packages:',
                                      style:
                                          AppTextStyles.ralewayFont20SemiBold(
                                              context),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: item.packages.length,
                                        itemBuilder: (context, index) {
                                          final package = item.packages[index];
                                          final packageName = item.selectedPackages[index];
                                          return Card(
                                            child: ListTile(
                                              title: Text(
                                                package,
                                                style: AppTextStyles
                                                    .nunitoFont16Regular(
                                                        context,
                                                        color: AppColors
                                                            .blackColor),
                                              ),
                                              trailing: Checkbox(
                                                value: item.selectedPackages[index].isSelected,
                                                onChanged: (value) {
                                                  if (value == null) return;
                                                  item.selectedPackages[index].isSelected = value;
                                                  context.read<TopicDetailsCubit>().updateDetailsItemForTopic(
                                                    topicId: widget.topic.topicId,
                                                    checklistId: widget.checklistId,
                                                    updatedDetails: item,
                                                  );

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: item.progress,
                                      backgroundColor: Colors.grey[300],
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
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
