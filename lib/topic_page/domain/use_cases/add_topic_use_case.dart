import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/repositories/topic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCheckListTopicUseCase {
  final TopicRepository _repository;

  AddCheckListTopicUseCase(this._repository);

  Future<void> execute(String checklistName,TopicEntity topic) async {
    await _repository.addTopic(checklistName,topic);
  }
}
