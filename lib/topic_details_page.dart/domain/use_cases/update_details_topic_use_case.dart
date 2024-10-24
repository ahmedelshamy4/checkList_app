import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTopicUseCase {
  final TopicDetailsRepository _repository;

  UpdateTopicUseCase(this._repository);

  Future<void> execute(
    String checklistId,
    String topicId,
    String detailsId,
    TopicDetailsEntity updatedDetails,
  ) async {
    await _repository.updateTopicDetails(
        checklistId, topicId, detailsId, updatedDetails,);
  }
}
