import 'package:equatable/equatable.dart';

  class TopicDetailsEntity extends Equatable {
    final String id;
    final String title;
    final String description;
    final String? subDescription;
    final List<String> packages;
    final List<PackageModel> selectedPackages;
    double progress;

    TopicDetailsEntity({
      required this.id,
      required this.title,
      required this.description,
      this.subDescription,
      required this.packages,
      required this.selectedPackages,
      required this.progress,
    });

    TopicDetailsEntity copyWith({
      String? id,
      String? title,
      String? description,
      String? subDescription,
      List<String>? packages,
      List<PackageModel>? selectedPackages,
      double? progress,
    }) {
      return TopicDetailsEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        subDescription: subDescription ?? this.subDescription,
        packages: packages ?? this.packages,
        selectedPackages: selectedPackages ?? this.selectedPackages,
        progress: progress ?? this.progress,
      );
    }

    @override
    List<Object?> get props => [
          id,
          title,
          description,
          subDescription,
          packages,
          selectedPackages,
          progress,
        ];
  }

  class PackageModel {
    final String name;
    bool isSelected;

    PackageModel({
      required this.name,
      this.isSelected = false,
    });

    PackageModel copyWith({
      String? name,
      bool? isSelected,
    }) {
      return PackageModel(
        name: name ?? this.name,
        isSelected: isSelected ?? this.isSelected,
      );
    }
  }
