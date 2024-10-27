import 'package:bloc/bloc.dart';
import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/core/utils/async.dart';
import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/home/domain/use_cases/add_%20check_list_item_use_case.dart';
import 'package:checklist_app/home/domain/use_cases/get_%20check_list_items_use_case.dart';
import 'package:checklist_app/home/domain/use_cases/remove_check_list_item_use_case.dart';
import 'package:checklist_app/home/domain/use_cases/saving_reorder_checklist_use_case.dart';
import 'package:checklist_app/home/domain/use_cases/update_check_list_item_use_case.dart';
import 'package:checklist_app/home/presentation/manager/checklist_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChecklistCubit extends Cubit<ChecklistState> {
  ChecklistCubit() : super(const ChecklistState.initial()) {
    _loadCases();
  }

  late GetChecklistItemsUseCase _getChecklistItemsUseCase;
  late AddChecklistItemUseCase _addChecklistItemUseCase;
  late RemoveChecklistItemUseCase _removeChecklistItemUseCase;
  late UpdateChecklistItemUseCase _updateChecklistItemUseCase;
  late SavingReorderChecklistUseCase _savingReorderChecklistUseCase;

  void _loadCases() async {
    _getChecklistItemsUseCase = injector();
    _addChecklistItemUseCase = injector();
    _removeChecklistItemUseCase = injector();
    _updateChecklistItemUseCase = injector();
    _savingReorderChecklistUseCase = injector();
  }

  Future<void> loadChecklistItems() async {
    emit(state.reduce(getChecklistItemsState: const Async.loading()));
    try {
      final result = await _getChecklistItemsUseCase.execute();
      emit(state.reduce(getChecklistItemsState: Async.success(result)));
      // print('Loaded ${result.length} items');
    } catch (e) {
      emit(state.reduce(
          getChecklistItemsState: Async.failure(Failure(e.toString()))));
    }
  }

  // Reorder checklist items and save them to Firestore...
  Future<void> reorderChecklist(int oldIndex, int newIndex) async {
    try {
      if (state.getChecklistItemsState.isSuccess) {
          final currentItems = state.getChecklistItemsState.data;
        List<ChecklistItem> updatedChecklist = List.from(currentItems ?? []);
        final movedItem = updatedChecklist.removeAt(oldIndex);
        updatedChecklist.insert(newIndex, movedItem);
        emit(state.reduce(
          getChecklistItemsState: Async.success(updatedChecklist),
        ));
        await _savingReorderChecklistUseCase.execute(updatedChecklist);
      }
    } catch (e) {
      print('Error while reordering: $e');
      emit(state.reduce(
          getChecklistItemsState: const Async.failure(
              Failure("Error saving reordered checklist"))));
    }
  }

  Future<void> addChecklistNewItem(ChecklistItem item) async {
    emit(state.reduce(addChecklistItemState: const Async.loading()));
    try {
      await _addChecklistItemUseCase.execute(item);
      emit(state.reduce(
          addChecklistItemState: const Async.successWithoutData()));
      await loadChecklistItems();
    } catch (e) {
      emit(state.reduce(
          addChecklistItemState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> removeChecklistItem(String id) async {
    emit(state.reduce(deleteChecklistItemState: const Async.loading()));
    try {
      await _removeChecklistItemUseCase.execute(id);
      emit(state.reduce(
          deleteChecklistItemState: const Async.successWithoutData()));
      await loadChecklistItems();
    } catch (e) {
      emit(state.reduce(
          deleteChecklistItemState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> updateChecklistNewItem(ChecklistItem item) async {
    emit(state.reduce(updateChecklistItemState: const Async.loading()));
    try {
      await _updateChecklistItemUseCase.execute(item);
      emit(state.reduce(
          updateChecklistItemState: const Async.successWithoutData()));
      await loadChecklistItems();
    } catch (e) {
      emit(state.reduce(
          updateChecklistItemState: Async.failure(Failure(e.toString()))));
    }
  }
}
