import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:flutter/material.dart';
class AddOrEditTopicDialog extends StatefulWidget {
  final TopicDetailsEntity? item;
  final String topicId;
  final String checklistId;
  final void Function(
      String topicId, String checklistId, TopicDetailsEntity details) onAddDetailsItemForTopicCallback;
  final void Function(
      String topicId, String checklistId, TopicDetailsEntity newDetails) onUpdateDetailsItemForTopicCallback;

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
  bool _isPackageError = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.title ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _subDescriptionController = TextEditingController(text: widget.item?.subDescription ?? '');
    _packageNameController = TextEditingController();
    _packageNames = List.from(widget.item?.packages ?? []);
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
                        _isPackageError = false;
                      });
                    }
                  },
                ),
              ],
            ),
            if (_isPackageError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please add at least one package.',
                  style: AppTextStyles.nunitoFont16Regular(context,color: Colors.red),
                ),
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
                          _packageNames.remove(e);
                        });
                      },
                    ),
                  ],
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_packageNames.isEmpty) {
              setState(() {
                _isPackageError = true;
              });
              return;
            }

            final updatedSelectedPackages = _packageNames.map((packageName) {
              final existingPackage = widget.item?.selectedPackages.firstWhere(
                    (package) => package.name == packageName,
                orElse: () => PackageModel(name: packageName, isSelected: false),
              );
              return existingPackage ?? PackageModel(name: packageName, isSelected: false);
            }).toList();

            final newItem = TopicDetailsEntity(
              title: _nameController.text,
              description: _descriptionController.text,
              subDescription: _subDescriptionController.text,
              id: widget.item?.id ?? '',
              progress: widget.item?.progress ?? 0.0,
              packages: _packageNames,
              selectedPackages: updatedSelectedPackages,
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

