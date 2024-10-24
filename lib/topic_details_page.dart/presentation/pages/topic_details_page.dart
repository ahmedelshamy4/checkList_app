import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/core/custom_widgets/toast_service.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_cubit.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_state.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/widgets/add_or_edit_topic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TopicDetailsPage extends StatelessWidget {
  final CheckListTopicEntity topic;
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
  final CheckListTopicEntity topic;
  final String checklistId;

  const _TopicDetailsForm(
      {super.key, required this.topic, required this.checklistId});

  @override
  State<_TopicDetailsForm> createState() => _TopicDetailsFormState();
}

class _TopicDetailsFormState extends State<_TopicDetailsForm> {
  List<TopicDetailsEntity> _detailsList = [];

  void _showAddOrEditTopicDialog(BuildContext context,
      {TopicDetailsEntity? item}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddOrEditTopicDialog(
          item: item,
          topicId: widget.topic.topicId,
          checklistId: widget.checklistId,
        );
      },
    );
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
                  ? ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
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
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    item.title,
                                    style: AppTextStyles.playfairFont16Bold(
                                        context),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      onPressed: () {
                                        context
                                            .read<TopicDetailsCubit>()
                                            .removeDetailsItemForTopic(
                                              checklistId: widget.checklistId,
                                              topicId: widget.topic.topicId,
                                              detailsId: item.id,
                                            );
                                      },
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
                              if (item.subDescription != null)
                                Text(
                                  item.subDescription!,
                                  style: AppTextStyles.nunitoFont16Regular(
                                      color: AppColors.blackColor, context),
                                ),
                              const Gap(PaddingDimensions.normal),
                              Text(
                                'Packages:',
                                style: AppTextStyles.ralewayFont20SemiBold(
                                    context),
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: item.packageNames.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        item.packageNames[index],
                                        style:
                                            AppTextStyles.nunitoFont16Regular(
                                                context,
                                                color: AppColors.blackColor),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : (state.getDetailsTopicsState.isLoading ||
                          state.addDetailsTopicState.isLoading)
                      ? const SizedBox.shrink()
                      : Center(
                          child: Text(
                          'No topics found',
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
