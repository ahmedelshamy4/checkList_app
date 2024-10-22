import 'package:checklist_app/checklist/data/models/api_check_list_item_model.dart';
import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/domain/repositories/check_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChecklistRepository)
class ChecklistRepositoryImpl implements ChecklistRepository {
  final FirebaseFirestore firestore;

  ChecklistRepositoryImpl({required this.firestore});

  @override
  Future<void> addItem(ChecklistItem item) async {
    try {
      final apiItem = ApiChecklistItemModel(id: item.id, name: item.name);
      await firestore.collection("checklist").add(apiItem.toFirestore());
      print("Item successfully added");
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  @override
  Future<List<ChecklistItem>> getItems() async {
    try {
      final snapshot = await firestore.collection("checklist").get();
      return snapshot.docs
          .map((doc) => ApiChecklistItemModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error retrieving items: $e");
      return [];
    }
  }

  @override
  Future<void> removeItem(String id) async {
    await firestore.collection("checklist").doc(id).delete();
  }
}
