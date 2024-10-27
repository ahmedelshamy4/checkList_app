// import 'package:checklist_app/home/domain/entities/check_list_item.dart';
//
// class ApiChecklistItemModel extends ChecklistItem {
//   const ApiChecklistItemModel({
//     required String id,
//     required String name,
//     required int? order,
//   }) : super(id: id, name: name, order: order);
//
//   factory ApiChecklistItemModel.fromFirestore(
//       Map<String, dynamic> json, String id) {
//     return ApiChecklistItemModel(
//       id: id,
//       name: json['name'],
//       order: json['order'] != null ? json['order'] as int : 0,
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'id': id,
//       if (order != null) 'order': order,
//     };
//   }
// }
