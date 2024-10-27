import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/repositories/topic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCheckListTopicUseCase {
  final TopicRepository _repository;

  UpdateCheckListTopicUseCase(this._repository);

  Future<void> execute(String checklistItemId, TopicEntity topic) async {
    await _repository.updateTopic(checklistItemId, topic);
  }
}
