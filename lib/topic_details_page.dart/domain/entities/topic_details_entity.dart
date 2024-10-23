import 'package:equatable/equatable.dart';

class TopicDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? subDescription;
  final List<String> packageNames;

  const TopicDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    this.subDescription,
    required this.packageNames,
  });

  TopicDetailsEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? subDescription,
    List<String>? packageNames,
  }) {
    return TopicDetailsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subDescription: subDescription ?? this.subDescription,
      packageNames: packageNames ?? this.packageNames,
    );
  }
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        packageNames,
      ];
}
