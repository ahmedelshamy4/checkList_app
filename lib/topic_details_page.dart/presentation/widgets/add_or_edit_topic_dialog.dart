import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:flutter/material.dart';

class AddOrEditTopicDialog extends StatefulWidget {
  final TopicDetailsEntity? item;
  final String topicId;
  final String checklistId;
  final void Function(
          String topicId, String checklistId, TopicDetailsEntity details)
      onAddDetailsItemForTopicCallback;
  final void Function(
          String topicId, String checklistId, TopicDetailsEntity newDetails)
      onUpdateDetailsItemForTopicCallback;

  const AddOrEditTopicDialog({
    super.key,
    this.item,
    required this.topicId,
    required this.checklistId,
    required this.onAddDetailsItemForTopicCallback,
    required this.onUpdateDetailsItemForTopicCallback,
  });

  @override
  _AddOrEditTopicDialogState createState() => _AddOrEditTopicDialogState();
}

class _AddOrEditTopicDialogState extends State<AddOrEditTopicDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _subDescriptionController;
  late TextEditingController _packageNameController;
  List<String> _packageNames = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _subDescriptionController =
        TextEditingController(text: widget.item?.subDescription ?? '');
    _packageNameController = TextEditingController();
    _packageNames = List.from(widget.item?.packageNames ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _subDescriptionController.dispose();
    _packageNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.item == null ? 'Add New Item' : 'Edit Item',
        style: AppTextStyles.nunitoFont20Medium(context),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Item Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            TextField(
              controller: _subDescriptionController,
              decoration: const InputDecoration(hintText: 'Sub Description'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _packageNameController,
                    decoration: const InputDecoration(hintText: 'Package Name'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_packageNameController.text.isNotEmpty) {
                      setState(() {
                        _packageNames.add(_packageNameController.text);
                        _packageNameController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _packageNames
                  .map(
                    (e) => Row(
                      children: [
                        Expanded(child: Text(e)),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _packageNames.removeAt(_packageNames.indexOf(e));
                            });
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newItem = TopicDetailsEntity(
              title: _nameController.text,
              description: _descriptionController.text,
              subDescription: _subDescriptionController.text,
              id: widget.item?.id ?? '',
              packageNames: _packageNames,
              selectedPackages: List.filled(_packageNames.length, false),
              progress: widget.item?.progress ?? 0.0,
            );
            if (widget.item == null) {
              widget.onAddDetailsItemForTopicCallback(
                widget.topicId,
                widget.checklistId,
                newItem,
              );
            } else {
              widget.onUpdateDetailsItemForTopicCallback(
                widget.topicId,
                widget.checklistId,
                newItem,
              );
            }
            Navigator.of(context).pop();
          },
          child: Text(
            widget.item == null ? 'Add' : 'Update',
            style: AppTextStyles.nunitoFont20Medium(context),
          ),
        ),
      ],
    );
  }
}
