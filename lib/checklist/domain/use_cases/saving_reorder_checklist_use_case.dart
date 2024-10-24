import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/domain/repositories/check_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavingReorderChecklistUseCase {
  final ChecklistRepository _checklistRepository;

  SavingReorderChecklistUseCase(this._checklistRepository);

  Future<void> execute(List<ChecklistItem> checklist) {
    return _checklistRepository.saveChecklistOrder(checklist);
  }
}
