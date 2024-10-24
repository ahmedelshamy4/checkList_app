import 'package:checklist_app/core/utils/async.dart';
import 'package:checklist_app/topic_details_page.dart/domain/entities/topic_details_entity.dart';
import 'package:equatable/equatable.dart';

class TopicDetailsState extends Equatable {
  final Async<void> updateDetailsTopicState;
  final Async<void> saveCheckedListState;
  final Async<void> addDetailsTopicState;
  final Async<void> removeDetailsTopicState;
  final Async<List<TopicDetailsEntity>> getDetailsTopicsState;
  final String? errorMessage;

  const TopicDetailsState(
    this.updateDetailsTopicState,
    this.saveCheckedListState,
    this.addDetailsTopicState,
    this.removeDetailsTopicState,
    this.getDetailsTopicsState,
    this.errorMessage,
  );

  const TopicDetailsState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          null,
        );

  TopicDetailsState reduce({
    Async<void>? updateDetailsTopicState,
    Async<void>? saveCheckedListState,
    Async<void>? addDetailsTopicState,
    Async<void>? removeDetailsTopicState,
    Async<List<TopicDetailsEntity>>? getDetailsTopicsState,
    String? errorMesage,
  }) {
    return TopicDetailsState(
      updateDetailsTopicState ?? this.updateDetailsTopicState,
      saveCheckedListState ?? this.saveCheckedListState,
      addDetailsTopicState ?? this.addDetailsTopicState,
      removeDetailsTopicState ?? this.removeDetailsTopicState,
      getDetailsTopicsState ?? this.getDetailsTopicsState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        updateDetailsTopicState,
        saveCheckedListState,
        addDetailsTopicState,
        removeDetailsTopicState,
        getDetailsTopicsState,
        errorMessage,
      ];
}
