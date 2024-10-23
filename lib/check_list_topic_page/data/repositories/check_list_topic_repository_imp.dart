import 'package:checklist_app/check_list_topic_page/domain/entities/check_list_topic_entity.dart';
import 'package:checklist_app/check_list_topic_page/domain/repositories/check_list_topic_repository.dart';
import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckListTopicRepository)
class CheckListTopicRepositoryImp implements CheckListTopicRepository {
  final FirebaseFirestore firestore;

  CheckListTopicRepositoryImp({required this.firestore});

  @override
  Future<void> addTopic(
      String checklistName, CheckListTopicEntity topic) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistName)
          .collection(AppConstants.topicsCollection)
          .add({
        'name': topic.name,
        'description': topic.description,
      });
      print('Topic added successfully');
    } catch (e) {
      print('Error adding topic: $e');
    }
  }

  @override
  Future<List<CheckListTopicEntity>> getTopicsByChecklistName(
      String checklistName) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistName)
          .collection(AppConstants.topicsCollection)
          .get();

      return snapshot.docs.map((doc) {
        return CheckListTopicEntity(
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
  Future<void> removeTopic(String checklistName, CheckListTopicEntity topic) async {
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
      String checklistName, CheckListTopicEntity updatedTopic) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistName)
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
}
