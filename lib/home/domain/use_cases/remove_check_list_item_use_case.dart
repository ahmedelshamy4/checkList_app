import 'package:checklist_app/home/domain/repositories/check_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveChecklistItemUseCase {
  final ChecklistRepository _repository;

  RemoveChecklistItemUseCase(this._repository);

  Future<void> execute(String id) async {
    await _repository.removeCheckListItem(id);
  }
}
