import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/core/utils/async.dart';
import 'package:equatable/equatable.dart';

class ChecklistState extends Equatable {
  final Async<void> addChecklistItemState;
  final Async<void> deleteChecklistItemState;
  final Async<List<ChecklistItem>> getChecklistItemsState;
  final String? errorMessage;

  const ChecklistState(
    this.addChecklistItemState,
    this.deleteChecklistItemState,
    this.getChecklistItemsState,
    this.errorMessage,
  );

  const ChecklistState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          null,
        );

  ChecklistState reduce({
    Async<void>? addChecklistItemState,
    Async<void>? deleteChecklistItemState,
    Async<List<ChecklistItem>>? getChecklistItemsState,
    String? errorMesage,
  }) {
    return ChecklistState(
      addChecklistItemState ?? this.addChecklistItemState,
      deleteChecklistItemState ?? this.deleteChecklistItemState,
      getChecklistItemsState ?? this.getChecklistItemsState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        addChecklistItemState,
        deleteChecklistItemState,
        getChecklistItemsState,
        errorMessage,
      ];
}
