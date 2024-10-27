import 'package:equatable/equatable.dart';

class TopicEntity extends Equatable {
  final String topicId;
  final String name;
  final String description;

  const TopicEntity({
    required this.topicId,
    required this.name,
    required this.description,
  });

  TopicEntity copyWith({
    String? topicId,
    String? name,
    String? description,
  }) {
    return TopicEntity(
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
