import 'package:checklist_app/core/utils/async.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final Async<int> updateSelectedTabIndex;
  final String? errorMessage;

  const AppState(
    this.updateSelectedTabIndex,
    this.errorMessage,
  );

  const AppState.initial()
      : this(
          const Async.initial(),
          null,
        );

  AppState reduce({
    Async<int>? updateSelectedTabIndex,
    String? errorMesage,
  }) {
    return AppState(
      updateSelectedTabIndex ?? this.updateSelectedTabIndex,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        updateSelectedTabIndex,
        errorMessage,
      ];
}
