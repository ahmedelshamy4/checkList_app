import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';

abstract class CheckListTopicRepository {
  Future<void> addTopic(String checklistName, CheckListTopicEntity topic);
  Future<List<CheckListTopicEntity>> getTopicsByChecklistName(
      String checklistName);
  Future<void> removeTopic(String checklistName, CheckListTopicEntity topic);
  Future<void> updateTopic(String checklistName,CheckListTopicEntity topic);
}
