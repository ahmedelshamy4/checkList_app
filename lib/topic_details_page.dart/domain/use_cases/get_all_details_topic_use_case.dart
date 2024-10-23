import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllDetailsTopicUseCase {
  final TopicDetailsRepository repository;

  GetAllDetailsTopicUseCase(this.repository);

  Future<List<TopicDetailsEntity>> execute(
    String checklistId,
    String topicId,
  ) async {
    return await repository.getAllTopicDetailsItems(checklistId, topicId);
  }
}
