import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> packageNames;

  const ItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.packageNames,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        packageNames,
      ];
}