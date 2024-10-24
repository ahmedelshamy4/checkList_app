import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/domain/repositories/check_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddChecklistItemUseCase {
  final ChecklistRepository _repository;

  AddChecklistItemUseCase(this._repository);

  Future<void> execute(ChecklistItem item) async {
    await _repository.addCheckListItem(item);
  }
}
