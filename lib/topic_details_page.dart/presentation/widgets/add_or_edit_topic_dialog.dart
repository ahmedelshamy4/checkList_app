import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_cubit.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/widgets/package_check_box_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrEditTopicDialog extends StatefulWidget {
  final TopicDetailsEntity? item;
  final String topicId;
  final String checklistId;

  const AddOrEditTopicDialog({
    super.key,
    this.item,
    required this.topicId,
    required this.checklistId,
  });

  @override
  _AddOrEditTopicDialogState createState() => _AddOrEditTopicDialogState();
}

class _AddOrEditTopicDialogState extends State<AddOrEditTopicDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _subDescriptionController;
  List<String> _packageNames = [];
  List<bool> _selectedPackages = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _subDescriptionController =
        TextEditingController(text: widget.item?.subDescription ?? '');
    _packageNames = widget.item?.packageNames ?? [];
    _selectedPackages = List.generate(_packageNames.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add New Item' : 'Edit Item'),
      content: Column(
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
          PackageCheckboxList(
            packageNames: _packageNames,
            selectedPackages: _selectedPackages,
            onPackageChecked: (index, isChecked) {
              setState(() {
                _selectedPackages[index] = isChecked;
              });
            },
          ),
        ],
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
            );
            if (widget.item == null) {
              context.read<TopicDetailsCubit>().addDetailsItemForTopic(
                    topicId: widget.topicId,
                    checklistId: widget.checklistId,
                    details: newItem,
                  );
            } else {
              context.read<TopicDetailsCubit>().updateDetailsItemForTopic(
                    topicId: widget.topicId,
                    checklistId: widget.checklistId,
                    updatedDetails: newItem,
                  );
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.item == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final List<bool> selectedPackages;

  const ProgressBar({super.key, required this.selectedPackages});

  @override
  Widget build(BuildContext context) {
    int checkedCount = selectedPackages.where((isChecked) => isChecked).length;
    double progress =
        selectedPackages.isEmpty ? 0 : checkedCount / selectedPackages.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LinearProgressIndicator(value: progress),
    );
  }
}
