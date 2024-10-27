
import 'package:checklist_app/home/domain/entities/check_list_item.dart';

abstract class ChecklistRepository {
  Future<List<ChecklistItem>> getCheckListItems();
  Future<void> addCheckListItem(ChecklistItem item);
  Future<void> removeCheckListItem(String id);
  Future<void> updateCheckListItem(ChecklistItem item);
  Future<void>  saveChecklistOrder(List<ChecklistItem> checklist);
}
