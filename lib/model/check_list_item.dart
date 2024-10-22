import 'package:checklist_app/model/package_item.dart';
import 'package:equatable/equatable.dart';

class CheckListItem extends Equatable {
  String text;
  String description;
  List<PackageItem> packageList;
  bool isChecked;

  CheckListItem({
    required this.text,
    required this.description,
    required this.packageList,
    this.isChecked = false,
  });

// From JSON method
  factory CheckListItem.fromJson(Map<String, dynamic> json) {
    var packageListFromJson =json['packageList'] ==null ? [] : json['packageList'] as List;
    List<PackageItem> packageListItems =
        packageListFromJson.map((item) => PackageItem.fromJson(item)).toList();

    return CheckListItem(
      text: json['text'] as String,
      description: json['description'] as String,
      packageList: packageListItems,
      isChecked: json['isChecked'] as bool,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'description': description,
      'packageList':
          packageList.map((packageItem) => packageItem.toJson()).toList(),
      'isChecked': isChecked,
    };
  }

  @override
  List<Object?> get props => [
        text,
        description,
        packageList,
        isChecked,
      ];
}
