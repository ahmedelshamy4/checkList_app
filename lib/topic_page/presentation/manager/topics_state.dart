import 'package:checklist_app/core/utils/async.dart';
import 'package:checklist_app/topic_page/domain/entities/topic_entity.dart';
import 'package:equatable/equatable.dart';

class TopicsState extends Equatable {
  final Async<void> addTopicState;
  final Async<void> removeTopicState;
  final Async<void> updateTopicState;
  final Async<List<TopicEntity>> getTopicsState;
  final String? errorMessage;

  const TopicsState(
    this.addTopicState,
    this.removeTopicState,
    this.updateTopicState,
    this.getTopicsState,
    this.errorMessage,
  );

  const TopicsState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
          null,
        );

  TopicsState reduce({
    Async<void>? addTopicState,
    Async<void>? updateTopicState,
    Async<void>? removeTopicState,
    Async<List<TopicEntity>>? getTopicsState,
    String? errorMesage,
  }) {
    return TopicsState(
      addTopicState ?? this.addTopicState,
      updateTopicState ?? this.updateTopicState,
      removeTopicState ?? this.removeTopicState,
      getTopicsState ?? this.getTopicsState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        addTopicState,
        updateTopicState,
        removeTopicState,
        getTopicsState,
        errorMessage,
      ];
}
