import 'package:bloc/bloc.dart';
import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/domain/use_cases/add_%20check_list_item_use_case.dart';
import 'package:checklist_app/checklist/domain/use_cases/get_%20check_list_items_use_case.dart';
import 'package:checklist_app/checklist/domain/use_cases/remove_check_list_item_use_case.dart';
import 'package:checklist_app/checklist/presentation/manager/checklist_state.dart';
import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/core/utils/async.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChecklistCubit extends Cubit<ChecklistState> {
  ChecklistCubit() : super(const ChecklistState.initial()) {
    _loadCases();
  }

  late GetChecklistItemsUseCase _getChecklistItemsUseCase;
  late AddChecklistItemUseCase _addChecklistItemUseCase;
  late RemoveChecklistItemUseCase _removeChecklistItemUseCase;

  void _loadCases() async {
    _getChecklistItemsUseCase = injector();
    _addChecklistItemUseCase = injector();
    _removeChecklistItemUseCase = injector();
  }

  Future<void> loadItems() async {
    emit(state.reduce(getChecklistItemsState: const Async.loading()));
    try {
      final result = await _getChecklistItemsUseCase.execute();
      emit(state.reduce(getChecklistItemsState: Async.success(result)));
      print('Loaded ${result.length} items');
    } catch (e) {
      emit(state.reduce(
          getChecklistItemsState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> addChecklistNewItem(ChecklistItem item) async {
    emit(state.reduce(addChecklistItemState: const Async.loading()));
    try {
      await _addChecklistItemUseCase.execute(item);
      emit(state.reduce(
          addChecklistItemState: const Async.successWithoutData()));
      await loadItems();
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
      await loadItems();
    } catch (e) {
      emit(state.reduce(
          deleteChecklistItemState: Async.failure(Failure(e.toString()))));
    }
  }
}
