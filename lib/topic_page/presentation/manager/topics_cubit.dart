import 'package:bloc/bloc.dart';
import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/home/domain/entities/check_list_item.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/use_cases/add_topic_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/get_topics_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/remove_topic_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/save_topic_order_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/update_check_list_topic_use_case.dart';
import 'package:checklist_app/topic_page/presentation/manager/topics_state.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/async.dart';

@injectable
class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit() : super(const TopicsState.initial()) {
    _addTopicUseCase = injector();
    _getTopicsUseCase = injector();
    _removeTodoUseCase = injector();
    _updateCheckListTopicUseCase = injector();
    // _saveTopicOrderUseCase = injector();
  }

  late final AddCheckListTopicUseCase _addTopicUseCase;
  late final GetCheckListTopicsUseCase _getTopicsUseCase;
  late RemoveCheckListTopicUseCase _removeTodoUseCase;
  late UpdateCheckListTopicUseCase _updateCheckListTopicUseCase;
  // late SaveTopicOrderUseCase _saveTopicOrderUseCase;

  Future<void> addNewTopic(
    String checklistItemId,
    TopicEntity topic,
  ) async {
    emit(state.reduce(addTopicState: const Async.loading()));
    try {
      await _addTopicUseCase.execute(checklistItemId, topic);
      emit(state.reduce(addTopicState: const Async.successWithoutData()));
      await fetchTopicsByChecklistName(checklistItemId);
    } catch (e) {
      emit(state.reduce(addTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> fetchTopicsByChecklistName(String checklistItemId) async {
    try {
      emit(state.reduce(getTopicsState: const Async.loading()));
      final topics = await _getTopicsUseCase.execute(checklistItemId);
      emit(state.reduce(getTopicsState: Async.success(topics)));
      print('Loaded topics data: ${topics.length} topics');
    } catch (e) {
      emit(state.reduce(getTopicsState: Async.failure(Failure(e.toString()))));
    }
  }

  // Future<void> reorderTopiclist(int oldIndex, int newIndex) async {
  //   try {
  //     if (state.getTopicsState.isSuccess) {
  //       final currentItems = state.getTopicsState.data;
  //       List<TopicEntity> updatedChecklist = List.from(currentItems ?? []);
  //       final movedItem = updatedChecklist.removeAt(oldIndex);
  //       updatedChecklist.insert(newIndex, movedItem);
  //       emit(state.reduce(
  //         getTopicsState: Async.success(updatedChecklist),
  //       ));
  //       await _saveTopicOrderUseCase.execute(updatedChecklist);
  //     }
  //   } catch (e) {
  //     print('Error while reordering: $e');
  //     emit(state.reduce(
  //         getTopicsState: const Async.failure(
  //             Failure("Error saving topics checklist"))));
  //   }
  // }

  Future<void> deleteTopic({
    required ChecklistItem checklistItem,
    required TopicEntity topic,
  }) async {
    emit(state.reduce(removeTopicState: const Async.loading()));
    try {
      await _removeTodoUseCase.execute(checklistItem.id, topic);
      emit(state.reduce(removeTopicState: const Async.successWithoutData()));
      print('Removed topic successfully');
      await fetchTopicsByChecklistName(checklistItem.id);
    } catch (e) {
      emit(
          state.reduce(removeTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> updateTopic({
    required String checklistItemId,
    required TopicEntity topic,
  }) async {
    emit(state.reduce(updateTopicState: const Async.loading()));
    try {
      await _updateCheckListTopicUseCase.execute(checklistItemId, topic);
      emit(state.reduce(updateTopicState: const Async.successWithoutData()));
      await fetchTopicsByChecklistName(checklistItemId);
    } catch (e) {
      emit(
          state.reduce(updateTopicState: Async.failure(Failure(e.toString()))));
    }
  }
}
