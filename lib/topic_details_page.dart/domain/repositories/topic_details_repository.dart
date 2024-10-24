import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';

abstract class TopicDetailsRepository {
  Future<void> addTopicDetailsItem(
    String checklistId,
    String topicId,
    TopicDetailsEntity details,
  );

  Future<void> updateTopicDetails(
    String checklistId,
    String topicId,
    String detailsId,
    TopicDetailsEntity updatedDetails,
  );

  Future<void> deleteTopicDetailsItem(
    String checklistId,
    String topicId,
    String detailsId,
  );

  Future<List<TopicDetailsEntity>> getAllTopicDetailsItems(
    String checklistId,
    String topicId,
  );

}
