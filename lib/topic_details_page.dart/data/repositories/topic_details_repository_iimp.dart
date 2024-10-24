import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TopicDetailsRepository)
class TopicDetailsRepositoryImp implements TopicDetailsRepository {
  final FirebaseFirestore firestore;

  TopicDetailsRepositoryImp(this.firestore);

  @override
  Future<void> addTopicDetailsItem(
    String checklistId,
    String topicId,
    TopicDetailsEntity detailsItem,
  ) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistId)
          .collection(AppConstants.topicsCollection)
          .doc(topicId)
          .collection(AppConstants.topicDetailsCollection)
          .add({
        'title': detailsItem.title,
        'description': detailsItem.description,
        'subDescription': detailsItem.subDescription,
        'packageNames': detailsItem.packageNames,
        'selectedPackages': detailsItem.selectedPackages.isEmpty
            ? List<bool>.filled(detailsItem.packageNames.length, false)
            : detailsItem.selectedPackages,
        'progress': detailsItem.progress ?? 0.0,
      });
      print("Topic details item added successfully");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Future<List<TopicDetailsEntity>> getAllTopicDetailsItems(
      String checklistId, String topicId) async {
    try {
      final querySnapshot = await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistId)
          .collection(AppConstants.topicsCollection)
          .doc(topicId)
          .collection(AppConstants.topicDetailsCollection)
          .get();

      return querySnapshot.docs
          .map((doc) => TopicDetailsEntity(
                id: doc.id,
                title: doc['title'],
                description: doc['description'],
                subDescription: doc['subDescription'],
                packageNames: List<String>.from(doc['packageNames']),
        selectedPackages: doc.data().containsKey('selectedPackages')
            ? List<bool>.from(doc['selectedPackages'])
            : List<bool>.filled(
            doc['packageNames'].length, false), // Default to false if missing
        progress: doc.data().containsKey('progress')
            ? doc['progress']
            : 0.0, // Default to 0.0
              ))
          .toList();
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  @override
  Future<void> deleteTopicDetailsItem(
      String checklistId, String topicId, String detailsId) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistId)
          .collection(AppConstants.topicsCollection)
          .doc(topicId)
          .collection(AppConstants.topicDetailsCollection)
          .doc(detailsId)
          .delete();
      print("Topic details deleted successfully");
    } catch (e) {
      print("Error deleting topic details: $e");
    }
  }

  @override
  Future<void> updateTopicDetails(String checklistId, String topicId,
      String detailsId, TopicDetailsEntity updatedDetails) async {
    try {
      await firestore
          .collection(AppConstants.checklistCollection)
          .doc(checklistId)
          .collection(AppConstants.topicsCollection)
          .doc(topicId)
          .collection(AppConstants.topicDetailsCollection)
          .doc(detailsId)
          .update({
        'title': updatedDetails.title,
        'description': updatedDetails.description,
        'subDescription': updatedDetails.subDescription,
        'packageNames': updatedDetails.packageNames,
        'selectedPackages': updatedDetails.selectedPackages,
        'progress': updatedDetails.progress,
      });
      print("Topic details updated successfully");
    } catch (e) {
      print("Error updating topic details: $e");
    }
  }
}
