import 'package:equatable/equatable.dart';

class ChecklistItem extends Equatable {
  final String id;
  final String name;
  final int? order;

  const ChecklistItem({
    required this.id,
    required this.name,
     this.order,
  });

  ChecklistItem copyWith({
    String? id,
    String? name,
    int? order,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        order,
      ];
}
