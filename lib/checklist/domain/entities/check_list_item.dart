import 'package:equatable/equatable.dart';

class ChecklistItem extends Equatable {
  final String id;
  final String name;

  const ChecklistItem({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
