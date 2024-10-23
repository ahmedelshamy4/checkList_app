import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/pages/topic_details_page.dart';
import 'package:flutter/material.dart';

class BuiltTopicCard extends StatelessWidget {
  const BuiltTopicCard(
      {super.key,
      required this.topic,
      required this.onDelete,
      required this.onUpdate});

  final CheckListTopicEntity topic;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(topic.name),
      subtitle: Text(topic.description),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TopicDetailsPage(topic: topic),
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
