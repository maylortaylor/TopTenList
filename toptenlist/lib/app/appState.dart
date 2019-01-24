import 'package:meta/meta.dart';
import 'package:toptenlist/models/List.dart';

@immutable
class AppState {
  final List<AppList> appLists;
  final bool isLoading;

  AppState({
    @required this.appLists,
    @required this.isLoading,
  });

  AppState.initialState()
      : appLists = <AppList>[],
        isLoading = false;

  AppState copyWith({List<AppList> appLists, bool isLoading}) {
    return AppState(
      appLists: appLists ?? this.appLists,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
