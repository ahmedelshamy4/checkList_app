import 'package:checklist_app/model/check_list_item.dart';

class TabDataModel {
  String tabName;
  String tabDescription;
  List<CheckListItem> checkListItems;
  double progress;
  TabDataModel({
    required this.tabName,
    required this.tabDescription,
    this.checkListItems = const [],
    this.progress = 0.0,
  });
  Map<String, dynamic> toJson() {
    return {
      'tabName': tabName,
      'tabDescription': tabDescription,
      'checkListItems': checkListItems.map((item) => item.toJson()).toList(),
      'progress': progress,
    };
  }

  factory TabDataModel.fromJson(Map<String, dynamic> json) {
    return TabDataModel(
      tabName: json['tabName'],
      tabDescription: json['tabDescription'],
      checkListItems: (json['checkListItems'] as List)
          .map((item) => CheckListItem.fromJson(item))
          .toList(),
      progress: json['progress'] ?? 0.0,
    );
  }
}
