import 'package:bloc/bloc.dart';
import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:checklist_app/topic_page/domain/use_cases/add_topic_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/get_topics_use_case.dart';
import 'package:checklist_app/topic_page/domain/use_cases/remove_topic_use_case.dart';
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
  }

  late final AddCheckListTopicUseCase _addTopicUseCase;
  late final GetCheckListTopicsUseCase _getTopicsUseCase;
  late RemoveCheckListTopicUseCase _removeTodoUseCase;
  late UpdateCheckListTopicUseCase _updateCheckListTopicUseCase;

  Future<void> addNewTopic(
      String checklistName, TopicEntity topic) async {
    emit(state.reduce(addTopicState: const Async.loading()));
    try {
      await _addTopicUseCase.execute(checklistName, topic);
      emit(state.reduce(addTopicState: const Async.successWithoutData()));
      await fetchTopicsByChecklistName(checklistName);
    } catch (e) {
      emit(state.reduce(addTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> fetchTopicsByChecklistName(String checklistName) async {
    emit(state.reduce(getTopicsState: const Async.loading()));
    try {
      final topics = await _getTopicsUseCase.execute(checklistName);
      emit(state.reduce(getTopicsState: Async.success(topics)));
      print('Loaded ${topics.length} topics');
    } catch (e) {
      emit(state.reduce(getTopicsState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> deleteTopic({
    required String checklistName,
    required TopicEntity topic,
  }) async {
    emit(state.reduce(removeTopicState: const Async.loading()));
    try {
      await _removeTodoUseCase.execute(checklistName, topic);
      emit(state.reduce(removeTopicState: const Async.successWithoutData()));
      print('Removed topic successfully');
      await fetchTopicsByChecklistName(checklistName);
    } catch (e) {
      emit(
          state.reduce(removeTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> updateTopic({
    required String checklistName,
    required TopicEntity topic,
  }) async {
    emit(state.reduce(updateTopicState: const Async.loading()));
    try {
      await _updateCheckListTopicUseCase.execute(checklistName, topic);
      emit(state.reduce(updateTopicState: const Async.successWithoutData()));
      await fetchTopicsByChecklistName(checklistName);
    } catch (e) {
      emit(
          state.reduce(updateTopicState: Async.failure(Failure(e.toString()))));
    }
  }
}
