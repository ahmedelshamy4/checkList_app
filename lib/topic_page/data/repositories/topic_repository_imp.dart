import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/repositories/topic_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TopicRepository)
class CheckListTopicRepositoryImp implements TopicRepository {
  final FirebaseFirestore firestore;

  CheckListTopicRepositoryImp({required this.firestore});

  @override
  Future<void> addTopic(String checklistId, TopicEntity topic) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistId)
          .collection(AppConstants.topicsCollection)
          .add({
        'name': topic.name,
        'description': topic.description,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Topic added successfully');
    } catch (e) {
      print('Error adding topic: $e');
    }
  }

  @override
  Future<List<TopicEntity>> getTopicsByChecklistName(
      String checklistItemId) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistItemId)
          .collection(AppConstants.topicsCollection)
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        return TopicEntity(
          topicId: doc.id,
          name: doc['name'],
          description: doc['description'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching topics: $e');
    }
  }

  @override
  Future<void> removeTopic(String checklistName, TopicEntity topic) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistName)
          .collection(AppConstants.topicsCollection)
          .doc(topic.topicId)
          .delete();
      print('Topic removed successfully');
    } catch (e) {
      print('Error removing topic: $e');
    }
  }

  @override
  Future<void> updateTopic(
    String checklistItemId,
    TopicEntity updatedTopic,
  ) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistItemId)
          .collection(AppConstants.topicsCollection)
          .doc(updatedTopic.topicId)
          .update({
        'name': updatedTopic.name,
        'description': updatedTopic.description,
      });
      print('Topic updated successfully');
    } catch (e) {
      print('Error updating topic: $e');
    }
  }

// @override
// Future<void> saveTopicOrder(List<TopicEntity> topicsSaved) async {
//   try {
//     for (int index = 0; index < topicsSaved.length; index++) {
//       final item = topicsSaved[index];
//       final updatedItem = item.copyWith(order: index);
//       await firestore
//           .collection(AppConstants.checklistCollection)
//           .doc(updatedItem.topicId)
//           .update({
//         'name': updatedItem.name,
//         'description': updatedItem.description,
//         'order': updatedItem.order,
//       });
//     }
//     print(" order successfully updated");
//   } catch (e) {
//     print("Error saving checklist order: $e");
//   }
// }
}
