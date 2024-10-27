import 'package:checklist_app/core/custom_widgets/main_button.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UpdateTopicFormDialog extends StatelessWidget {
  final TopicEntity topic;
  final String checklistName;

  final void Function(String checklistName, TopicEntity topic)
      onUpdateTopic;

  const UpdateTopicFormDialog({
    super.key,
    required this.topic,
    required this.checklistName,
    required this.onUpdateTopic,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Update Topic',
        style: AppTextStyles.nunitoFont20Medium(context),
      ),
      content: _UpdateTopicForm(
        topic: topic,
        checklistName: checklistName,
        onUpdateTopic: onUpdateTopic,
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
  }
}

class _UpdateTopicForm extends StatefulWidget {
  final TopicEntity topic;
  final String checklistName;
  final void Function(String checklistName, TopicEntity topic)
      onUpdateTopic;

  const _UpdateTopicForm({
    super.key,
    required this.topic,
    required this.checklistName,
    required this.onUpdateTopic,
  });

  @override
  _UpdateTopicFormState createState() => _UpdateTopicFormState();
}

class _UpdateTopicFormState extends State<_UpdateTopicForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.topic.name);
    _descriptionController =
        TextEditingController(text: widget.topic.description);
  }
@override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
            decoration: const InputDecoration(labelText: 'Topic Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Topic Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const Gap(PaddingDimensions.large),
          MainButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final updatedTopic = widget.topic.copyWith(
                  name: _nameController.text,
                  description: _descriptionController.text,
                );
                widget.onUpdateTopic(widget.checklistName, updatedTopic);
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
