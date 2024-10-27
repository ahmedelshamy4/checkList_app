import 'package:equatable/equatable.dart';

class ChecklistItem extends Equatable{
  final String id;
  final String name;
  final int order;

  ChecklistItem({required this.id, required this.name, required this.order});

  // Convert ChecklistItem to Firestore-friendly map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'order': order,
    };
  }

  // Create ChecklistItem from Firestore data
  factory ChecklistItem.fromFirestore(Map<String, dynamic> data, String id) {
    return ChecklistItem(
      id: id,
      name: data['name'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  // Add copyWith for id assignment in addCheckListItem
  ChecklistItem copyWith({String? id, String? name, int? order}) {
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
