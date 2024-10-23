
import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/check_list_topic_page/domain/repositories/check_list_topic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCheckListTopicsUseCase {
  final CheckListTopicRepository _repository;

  GetCheckListTopicsUseCase(this._repository);

  Future<List<CheckListTopicEntity>> execute(String checklistName) async{
    return await _repository.getTopicsByChecklistName(checklistName);
  }
}