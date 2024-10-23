import 'package:equatable/equatable.dart';

class CheckListTopicEntity extends Equatable {
  final String topicId;
  final String name;
  final String description;

  const CheckListTopicEntity({
    required this.topicId,
    required this.name,
    required this.description,
  });
  CheckListTopicEntity copyWith({
    String? topicId,
    String? name,
    String? description,
  }) {
    return CheckListTopicEntity(
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        topicId,
        name,
        description,
      ];
}
