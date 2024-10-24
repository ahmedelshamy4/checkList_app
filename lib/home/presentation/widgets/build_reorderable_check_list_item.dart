import 'package:checklist_app/core/custom_widgets/main_button.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/presentation/manager/checklist_cubit.dart';
import 'package:checklist_app/topic_page/presentation/pages/topic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BuildReorderableCheckListItem extends StatefulWidget {
  const BuildReorderableCheckListItem(
      {super.key, required this.checklistItems});

  final List<ChecklistItem> checklistItems;

  @override
  State<BuildReorderableCheckListItem> createState() =>
      _BuildReorderableCheckListItemState();
}

class _BuildReorderableCheckListItemState
    extends State<BuildReorderableCheckListItem> {
  void _onRemoveChecklistTopic(String id) {
    widget.checklistItems
        .removeWhere((checklistItem) => checklistItem.id == id);
    context.read<ChecklistCubit>().removeChecklistItem(id);
    setState(() {});
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    context.read<ChecklistCubit>().reorderChecklist(oldIndex, newIndex);
    setState(() {});
  }

  void _onUpdateCheckListTopic(ChecklistItem newUpdateCheckList) {
    context.read<ChecklistCubit>().updateChecklistNewItem(newUpdateCheckList);
  }

  void _navigateToTopicDetailsPage(ChecklistItem checklistItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicPage(checklistItem: checklistItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: _onReorder,
      itemCount: widget.checklistItems.length,
      itemBuilder: (context, index) {
        final checklistItem = widget.checklistItems[index];
        return ListTile(
          key: ValueKey(checklistItem.id),
          onTap: () => _navigateToTopicDetailsPage(checklistItem),
          title: Text(
            checklistItem.name,
            style: AppTextStyles.playfairFont24Bold(context),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Remove Topic?',
                          style: AppTextStyles.nunitoFont20Medium(context),
                        ),
                        content: Text(
                          'Are you sure you want to remove this topic?',
                          style: AppTextStyles.nunitoFont20Medium(context),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _onRemoveChecklistTopic(checklistItem.id);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove',
                              style: AppTextStyles.nunitoFont20Bold(context),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: AppTextStyles.nunitoFont20Bold(context),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Update Topic',
                          style: AppTextStyles.nunitoFont20Medium(context),
                        ),
                        content: _UpdateCheckListTopicForm(
                          entity: checklistItem,
                          onUpdateCheckList: _onUpdateCheckListTopic,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: AppTextStyles.nunitoFont20Bold(context),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UpdateCheckListTopicForm extends StatefulWidget {
  final ChecklistItem entity;
  final void Function(ChecklistItem newUpdateCheckList) onUpdateCheckList;

  const _UpdateCheckListTopicForm(
      {super.key, required this.entity, required this.onUpdateCheckList});

  @override
  State<_UpdateCheckListTopicForm> createState() =>
      _UpdateCheckListTopicFormState();
}

class _UpdateCheckListTopicFormState extends State<_UpdateCheckListTopicForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.entity.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration:
                const InputDecoration(labelText: 'Checklist topic name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Checklist topic name';
              }
              return null;
            },
          ),
          const Gap(PaddingDimensions.large),
          MainButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final updatedTopic = widget.entity.copyWith(
                  name: _nameController.text,
                );
                widget.onUpdateCheckList(updatedTopic);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Update Topic',
              style: AppTextStyles.nunitoFont20Medium(context,
                  color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
