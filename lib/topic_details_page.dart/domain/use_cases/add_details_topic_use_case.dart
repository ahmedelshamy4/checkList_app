import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddDetailsTopicUseCase {
  final TopicDetailsRepository _repository;

  AddDetailsTopicUseCase(this._repository);

  Future<void> execute(
    String checklistId,
    String topicId,
    TopicDetailsEntity details,
  ) async {
    await _repository.addTopicDetailsItem(checklistId, topicId, details);
  }
}
