import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';

abstract class ChecklistRepository {
  Future<List<ChecklistItem>> getItems();
  Future<void> addItem(ChecklistItem item);
  Future<void> removeItem(String id);
}
