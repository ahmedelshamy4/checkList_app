import 'package:bloc/bloc.dart';
import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/core/utils/async.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/add_details_topic_use_case.dart';
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/delete_details_topic_use_case.dart';
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/get_all_details_topic_use_case.dart';
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/update_details_topic_use_case.dart';
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class TopicDetailsCubit extends Cubit<TopicDetailsState> {
  TopicDetailsCubit() : super(const TopicDetailsState.initial()) {
    _loadCases();
  }

  late final AddDetailsTopicUseCase _addDetailsTopicUseCase;
  late final GetAllDetailsTopicUseCase _getAllDetailsTopicUseCase;
  late final DeleteTopicUseCase _deleteTopicUseCase;
  late final UpdateTopicUseCase _updateTopicUseCase;

  void _loadCases() {
    _addDetailsTopicUseCase = injector();
    _getAllDetailsTopicUseCase = injector();
    _deleteTopicUseCase = injector();
    _updateTopicUseCase = injector();
  }

  Future<void> addDetailsItemForTopic({
    required String checklistId,
    required String topicId,
    required TopicDetailsEntity details,
  }) async {
    emit(state.reduce(addDetailsTopicState: const Async.loading()));
    try {
      await _addDetailsTopicUseCase.execute(checklistId, topicId, details);
      emit(
          state.reduce(addDetailsTopicState: const Async.successWithoutData()));
      await getAllDetailsItemsForTopic(
        checklistId: checklistId,
        topicId: topicId,
      );
    } catch (e) {
      emit(state.reduce(
          addDetailsTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> getAllDetailsItemsForTopic({
    required String checklistId,
    required String topicId,
  }) async {
    emit(state.reduce(getDetailsTopicsState: const Async.loading()));
    try {
      List<TopicDetailsEntity> details =
          await _getAllDetailsTopicUseCase.execute(checklistId, topicId);
      emit(state.reduce(getDetailsTopicsState: Async.success(details)));
      print(' Loaded ${details.length} details');
    } catch (e) {
      emit(state.reduce(
          getDetailsTopicsState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> removeDetailsItemForTopic({
    required String checklistId,
    required String topicId,
    required String detailsId,
  }) async {
    emit(state.reduce(removeDetailsTopicState: const Async.loading()));
    try {
      await _deleteTopicUseCase.execute(checklistId, topicId, detailsId);
      emit(state.reduce(
          removeDetailsTopicState: const Async.successWithoutData()));
      await getAllDetailsItemsForTopic(
          topicId: topicId, checklistId: checklistId);
    } catch (e) {
      emit(state.reduce(
          removeDetailsTopicState: Async.failure(Failure(e.toString()))));
    }
  }

  Future<void> updateDetailsItemForTopic({
    required String checklistId,
    required String  topicId,
    required TopicDetailsEntity updatedDetails,
  }) async {
    emit(state.reduce(updateDetailsTopicState: const Async.loading()));
    try {
      await _updateTopicUseCase.execute(
        checklistId,
       topicId,
        updatedDetails.id,
        updatedDetails,
      );
      emit(state.reduce(
          updateDetailsTopicState: const Async.successWithoutData()));
      await getAllDetailsItemsForTopic(
          checklistId: checklistId, topicId: topicId);
    } catch (e) {
      emit(state.reduce(
          updateDetailsTopicState: Async.failure(Failure(e.toString()))));
    }
  }
}