

import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/domain/repositories/check_list_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateChecklistItemUseCase {
  final ChecklistRepository _repository;
  UpdateChecklistItemUseCase(this._repository);
  Future<void> execute(ChecklistItem item) async {
    await _repository.updateCheckListItem(item);
  }
}