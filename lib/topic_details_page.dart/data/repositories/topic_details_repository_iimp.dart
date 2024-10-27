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
        'packageNames': detailsItem.packages,
        'selectedPackages': detailsItem.selectedPackages.isEmpty
            ? List<bool>.filled(detailsItem.packages.length, false)
            : detailsItem.selectedPackages
                .map(
                  (e) => {
                    'name': e.name,
                    'isSelected': e.isSelected,
                  },
                )
                .toList(),
        'progress': detailsItem.progress,
        'timestamp': FieldValue.serverTimestamp(),
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
          .orderBy('timestamp', descending: false)
          .get();

      return querySnapshot.docs.map((doc) {
        List<PackageModel> selectedPackages = [];

        // Check if 'selectedPackages' exists and is a List
        if (doc.data().containsKey('selectedPackages') &&
            doc['selectedPackages'] is List) {
          final rawSelectedPackages = doc['selectedPackages'] as List<dynamic>;

          selectedPackages = rawSelectedPackages.map((dynamic pkg) {
            if (pkg is Map<String, dynamic>) {
              final name = pkg['name'] ?? '';
              final isSelected = pkg['isSelected'] ?? false;
              return PackageModel(name: name, isSelected: isSelected);
            } else {
              print('Unexpected package format: $pkg');
              return PackageModel(name: '', isSelected: false);
            }
          }).toList();
        } else {
          print("No selected packages found or wrong format.");
        }

        return TopicDetailsEntity(
          id: doc.id,
          title: doc['title'] ?? '',
          description: doc['description'] ?? '',
          subDescription: doc['subDescription'] ?? '',
          packages: List<String>.from(doc['packageNames'] ?? []),
          // Ensure this is a List<String>
          selectedPackages: selectedPackages,
          progress: doc.data().containsKey('progress') ? doc['progress'] : 0.0,
        );
      }).toList();
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
  Future<void> updateTopicDetails(
    String checklistId,
    String topicId,
    String detailsId,
    TopicDetailsEntity updatedDetails,
  ) async {
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
        'packageNames': updatedDetails.packages,
        'selectedPackages': updatedDetails.selectedPackages
            .map((pkg) => {
                  'name': pkg.name,
                  'isSelected': pkg.isSelected,
                })
            .toList(),
        'progress': updatedDetails.progress,
      });
      print("Topic item changed successfully");
    } catch (e) {
      print("Error updating topic details: $e");
    }
  }
}
