import 'package:equatable/equatable.dart';

class TopicDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? subDescription;
  final List<String> packageNames;
   List<bool> selectedPackages;
   double progress;

   TopicDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    this.subDescription,
    required this.packageNames,
    required this.selectedPackages,
    required this.progress,
  });

  TopicDetailsEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? subDescription,
    List<String>? packageNames,
    List<bool>? selectedPackages,
    double? progress,
  }) {
    return TopicDetailsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subDescription: subDescription ?? this.subDescription,
      packageNames: packageNames ?? this.packageNames,
      selectedPackages: selectedPackages ?? this.selectedPackages,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        packageNames,
        selectedPackages,
        progress,
      ];
}
