import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/check_list_topic_page/presentation/manager/topics_cubit.dart';
import 'package:checklist_app/check_list_topic_page/presentation/manager/topics_state.dart';
import 'package:checklist_app/check_list_topic_page/presentation/widgets/built_topic_card.dart';
import 'package:checklist_app/check_list_topic_page/presentation/widgets/show_update_topic_dialog.dart';
import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/core/custom_widgets/toast_service.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListTopicPage extends StatelessWidget {
  const CheckListTopicPage({super.key, required this.checklistItem});

  final ChecklistItem checklistItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TopicsCubit()..fetchTopicsByChecklistName(checklistItem.name),
      child: TopicDetailsPageBody(
        checklistItem: checklistItem,
      ),
    );
  }
}

class TopicDetailsPageBody extends StatefulWidget {
  final ChecklistItem checklistItem;

  const TopicDetailsPageBody({super.key, required this.checklistItem});

  @override
  _TopicDetailsPageBodyState createState() => _TopicDetailsPageBodyState();
}

class _TopicDetailsPageBodyState extends State<TopicDetailsPageBody>
    with SingleTickerProviderStateMixin {
  List<CheckListTopicEntity> _topics = [];

  void _fetchTopics() async {
    final topics = context.read<TopicsCubit>().state.getTopicsState.data;
    setState(() {
      _topics = topics ?? [];
    });
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, String topicName) async {
    return showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Topic'),
              content: Text(
                  'Are you sure you want to delete the topic "$topicName"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _deleteTopic(CheckListTopicEntity topic) async {
    await context
        .read<TopicsCubit>()
        .deleteTopic(checklistName: widget.checklistItem.name, topic: topic);
    _topics.remove(topic);
    setState(() {});
  }

  void _addTopic(String name, String description) {
    final topic = CheckListTopicEntity(
      topicId: "",
      name: name,
      description: description,
    );
    context.read<TopicsCubit>().addNewTopic(widget.checklistItem.name, topic);
  }

  void showUpdateTopicDialog(
      BuildContext context, CheckListTopicEntity topic, String checklistName) {
    showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return UpdateTopicFormDialog(
          topic: topic,
          checklistName: checklistName,
          onUpdateTopic: (checklistName, topic) {
            context.read<TopicsCubit>().updateTopic(
                  checklistName: checklistName,
                  topic: topic,
                );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<TopicsCubit, TopicsState>(
          listener: (context, state) {
            if (state.getTopicsState.isSuccess) {
              _fetchTopics();
            }
            if (state.getTopicsState.isFailure) {
              ToastService().showToast(context, "Failed to fetch topics");
            }
            if (state.removeTopicState.isSuccess) {
              ToastService().showToast(context, "Topic removed successfully");
            } else if (state.removeTopicState.isFailure) {
              ToastService().showToast(context, "Failed to remove topic");
            }
            if (state.updateTopicState.isSuccess) {
              ToastService().showToast(context, "Topic updated successfully");
            } else if (state.updateTopicState.isFailure) {
              ToastService().showToast(context, "Failed to update topic");
            }
          },
          child: BlocBuilder<TopicsCubit, TopicsState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.checklistItem.name,
                    style: AppTextStyles.nunitoFont20Medium(context),
                  ),
                ),
                body: _topics.isNotEmpty
                    ? ListView.builder(
                        itemCount: _topics.length,
                        itemBuilder: (context, index) {
                          final topic = _topics[index];
                          return BuiltTopicCard(
                            topic: topic,
                            onDelete: () async {
                              bool confirmDelete =
                                  await _showDeleteConfirmationDialog(
                                          context, topic.name) ??
                                      false;
                              if (confirmDelete) {
                                _deleteTopic(topic);
                              }
                            },
                            onUpdate: () {
                              showUpdateTopicDialog(
                                  context, topic, widget.checklistItem.name);
                            },
                          );
                        },
                      )
                    : (state.getTopicsState.isLoading ||
                            state.addTopicState.isLoading)
                        ? const SizedBox.shrink()
                        : Center(
                            child: Text(
                              "No Topics Available",
                              style: AppTextStyles.nunitoFont20Medium(context),
                            ),
                          ),
                floatingActionButton: FloatingActionButton(
                  onPressed: _showAddTopicDialog,
                  child: const Icon(Icons.add),
                ),
              );
            },
          ),
        ),
        BlocBuilder<TopicsCubit, TopicsState>(
          builder: (context, state) {
            if (state.getTopicsState.isLoading ||
                state.addTopicState.isLoading) {
              return CustomLoader();
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  void _showAddTopicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String topicName = '';
        String topicDescription = '';

        return AlertDialog(
          title: Text(
            'Add New Topic',
            style: AppTextStyles.nunitoFont20Medium(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Topic Name'),
                onChanged: (value) {
                  topicName = value;
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Topic Description'),
                onChanged: (value) {
                  topicDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addTopic(topicName, topicDescription);
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: AppTextStyles.nunitoFont20Medium(context,
                    color: AppColors.blackColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
