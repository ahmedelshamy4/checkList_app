import 'package:equatable/equatable.dart';

class PackageItem extends Equatable{
  String packageName;
  bool isChecked;

  PackageItem({required this.packageName, this.isChecked = false});

  // From JSON method
  factory PackageItem.fromJson(Map<String, dynamic> json) {
    return PackageItem(
      packageName: json['packageName'] as String,
      isChecked: json['isChecked'] as bool,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'packageName': packageName,
      'isChecked': isChecked,
    };
  }
  @override
  List<Object> get props => [packageName, isChecked];
}