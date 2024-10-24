import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/pages/topic_details_page.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:flutter/material.dart';

class BuiltTopicCard extends StatelessWidget {
  const BuiltTopicCard(
      {super.key,
      required this.topic,
      required this.onDelete,
      required this.onUpdate,
      required this.checklistId});

  final TopicEntity topic;
  final String checklistId;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "💡${topic.name} ",
        style: AppTextStyles.nunitoFont20Medium(context,color: AppColors.blackColor),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
        child: Text(
          topic.description,
          style: AppTextStyles.nunitoFont20Medium(context),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TopicDetailsPage(
          topic: topic,
          checklistId: checklistId,
        ),
      )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onUpdate,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
