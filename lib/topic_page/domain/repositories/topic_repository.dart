import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';

abstract class TopicRepository {
  Future<void> addTopic(String checklistId, TopicEntity topic);
  Future<List<TopicEntity>> getTopicsByChecklistName(
      String checklistItemId);
  Future<void> removeTopic(String checklistName, TopicEntity topic);
  Future<void> updateTopic(String checklistName,TopicEntity topic);
}
