import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/check_list_topic_page/domain/repositories/check_list_topic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveCheckListTopicUseCase {
  final CheckListTopicRepository _repository;

  RemoveCheckListTopicUseCase(this._repository);

  Future<void> execute(String checklistName, CheckListTopicEntity topic) async {
    await _repository.removeTopic(checklistName,topic);
  }
}
