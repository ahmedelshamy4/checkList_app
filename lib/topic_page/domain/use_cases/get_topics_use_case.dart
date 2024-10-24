
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/repositories/topic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCheckListTopicsUseCase {
  final TopicRepository _repository;

  GetCheckListTopicsUseCase(this._repository);

  Future<List<TopicEntity>> execute(String checklistName) async{
    return await _repository.getTopicsByChecklistName(checklistName);
  }
}