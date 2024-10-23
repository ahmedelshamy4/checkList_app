import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTopicUseCase {
  final TopicDetailsRepository _repository;

  DeleteTopicUseCase(this._repository);

  Future<void> execute(
    String checklistId,
    String topicId,
    String detailsId,
  ) async {
    await _repository.deleteTopicDetailsItem(checklistId, topicId, detailsId);
  }
}
