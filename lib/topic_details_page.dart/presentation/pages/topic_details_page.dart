import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/core/custom_widgets/toast_service.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_cubit.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<TopicDetailsEntity> _list = [];

  void _showAddOrEditTopicDialog({TopicDetailsEntity? item}) {
    String topicItemName = item?.title ?? '';
    String topicItemDescription = item?.description ?? '';
    String topicItemSubDescription = item?.subDescription ?? '';
    String packageNames = item?.packageNames.join(', ') ?? '';

    showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return AlertDialog(
          title: Text(
            item == null ? 'Add New Item' : 'Edit Item',
            style: AppTextStyles.nunitoFont20Medium(contxt),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Item Name'),
                onChanged: (value) {
                  topicItemName = value;
                },
                controller: TextEditingController(text: topicItemName),
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Topic Description'),
                onChanged: (value) {
                  topicItemDescription = value;
                },
                controller: TextEditingController(text: topicItemDescription),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Sub Description'),
                onChanged: (value) {
                  topicItemSubDescription = value;
                },
                controller:
                    TextEditingController(text: topicItemSubDescription),
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Package Names (comma-separated)'),
                onChanged: (value) {
                  packageNames = value;
                },
                controller: TextEditingController(text: packageNames),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newItem = TopicDetailsEntity(
                  title: topicItemName,
                  description: topicItemDescription,
                  subDescription: topicItemSubDescription,
                  id: item?.id ?? '',
                  packageNames:
                      packageNames.split(',').map((e) => e.trim()).toList(),
                );

                if (item == null) {
                  context.read<TopicDetailsCubit>().addDetailsItemForTopic(
                        topicId: widget.topic.topicId,
                        checklistId: widget.checklistId,
                        details: newItem,
                      );
                } else {
                  context.read<TopicDetailsCubit>().updateDetailsItemForTopic(
                        topicId: widget.topic.topicId,
                        checklistId: widget.checklistId,
                        updatedDetails: newItem,
                      );
                }
                Navigator.of(contxt).pop();
              },
              child: Text(
                item == null ? 'Add' : 'Update',
                style: AppTextStyles.nunitoFont20Medium(contxt,
                    color: AppColors.blackColor),
              ),
            ),
          ],
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
              _list = state.getDetailsTopicsState.data ?? [];
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
              body: _list.isNotEmpty
                  ? ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        final item = _list[index];
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.description),
                              if (item.subDescription != null)
                                Text(item.subDescription!),
                              Text('Packages: ${item.packageNames.join(', ')}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showAddOrEditTopicDialog(item: _list[index]);
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
                          ),
                          onTap: () {},
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
                onPressed: _showAddOrEditTopicDialog,
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
