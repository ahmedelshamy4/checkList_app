import 'package:checklist_app/checklist/data/models/api_check_list_item_model.dart';
import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/domain/repositories/check_list_repository.dart';
import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChecklistRepository)
class ChecklistRepositoryImpl implements ChecklistRepository {
  final FirebaseFirestore firestore;

  ChecklistRepositoryImpl({required this.firestore});

  @override
  Future<void> addCheckListItem(ChecklistItem item) async {
    try {
      final apiItem =
          ApiChecklistItemModel(id: item.id, name: item.name, order: 0);
      await firestore
          .collection(AppConstants.checklistCollection)
          .add(apiItem.toFirestore());
      print("Item successfully added");
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  @override
  Future<List<ChecklistItem>> getCheckListItems() async {
    try {
      final snapshot = await firestore
          .collection(AppConstants.checklistCollection)
          .orderBy('order',descending: false)
          .get();
      return snapshot.docs
          .map((doc) => ApiChecklistItemModel.fromFirestore(
                doc.data(),
                doc.id,
              ))
          .toList();
    } catch (e) {
      print("Error retrieving items: $e");
      return [];
    }
  }

  @override
  Future<void> removeCheckListItem(String id) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(id)
          .delete();
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  @override
  Future<void> updateCheckListItem(ChecklistItem item) async {
    try {
      final apiItem = ApiChecklistItemModel(
        id: item.id,
        name: item.name,
        order: item.order,
      );
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(item.id)
          .update(apiItem.toFirestore());
      print("Item successfully updated");
    } catch (e) {
      print("Error updating item: $e");
    }
  }

  @override
  Future<void> saveChecklistOrder(List<ChecklistItem> checklist) async {
    try {
      for (int index = 0; index < checklist.length; index++) {
        final item = checklist[index];
        final apiItem = ApiChecklistItemModel(
          id: item.id,
          name: item.name,
          order: index,
        );
        await firestore
            .collection(AppConstants.checklistCollection)
            .doc(item.id)
            .update(apiItem.toFirestore());
      }
      print("Checklist order successfully updated");
    } catch (e) {
      print("Error saving checklist order: $e");
    }
  }
}
