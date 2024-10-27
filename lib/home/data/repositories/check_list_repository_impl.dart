import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/domain/repositories/check_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChecklistRepository)
@Injectable(as: ChecklistRepository)
class ChecklistRepositoryImpl implements ChecklistRepository {
  final FirebaseFirestore firestore;

  ChecklistRepositoryImpl({required this.firestore});

  @override
  Future<void> addCheckListItem(ChecklistItem item) async {
    try {
      final docRef = item.id.isEmpty
          ? firestore.collection(AppConstants.checklistCollection).doc()
          : firestore.collection(AppConstants.checklistCollection).doc(item.id);

      final checklistItemWithId =
          item.id.isEmpty ? item.copyWith(id: docRef.id) : item;

      await docRef.set(checklistItemWithId.toFirestore());
      print("Item successfully added with ID: ${checklistItemWithId.id}");
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  @override
  Future<List<ChecklistItem>> getCheckListItems() async {
    try {
      final snapshot = await firestore
          .collection(AppConstants.checklistCollection)
          .orderBy('order', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ChecklistItem.fromFirestore(doc.data(), doc.id))
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
      print("Item with ID $id successfully deleted");
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  @override
  Future<void> updateCheckListItem(ChecklistItem item) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(item.id)
          .update(item.toFirestore());
      print("Item with ID ${item.id} successfully updated");
    } catch (e) {
      print("Error updating item: $e");
    }
  }

  @override
  Future<void> saveChecklistOrder(List<ChecklistItem> checklist) async {
    try {
      for (int index = 0; index < checklist.length; index++) {
        final item = checklist[index];
        final updatedItem = item.copyWith(order: index);
        await firestore
            .collection(AppConstants.checklistCollection)
            .doc(updatedItem.id)
            .update(updatedItem.toFirestore());
      }
      print("Checklist order successfully updated");
    } catch (e) {
      print("Error saving checklist order: $e");
    }
  }
}
