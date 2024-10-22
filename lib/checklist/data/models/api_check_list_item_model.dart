import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';

class ApiChecklistItemModel extends ChecklistItem {
  const ApiChecklistItemModel({required String id, required String name})
      : super(id: id, name: name);

  factory ApiChecklistItemModel.fromFirestore(
      Map<String, dynamic> json, String id) {
    return ApiChecklistItemModel(
      id: id,
      name: json['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'id': id,
    };
  }
}
