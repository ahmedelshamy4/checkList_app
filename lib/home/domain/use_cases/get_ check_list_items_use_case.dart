import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/domain/repositories/check_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChecklistItemsUseCase {
  final ChecklistRepository _repository;

  GetChecklistItemsUseCase(this._repository);

  Future<List<ChecklistItem>> execute() async {
    return await _repository.getCheckListItems();
  }
}
