import 'package:meta/meta.dart';
import 'package:toptenlist/models/List.dart';

@immutable
class AppState {
  final List<AppListItem> applistItems;
  final bool isLoading;

  AppState({
    @required this.applistItems,
    @required this.isLoading,
  });

  AppState.initialState()
      : applistItems = <AppListItem>[],
        isLoading = false;

  AppState copyWith({List<AppListItem> applistItems, bool isLoading}) {
    return AppState(
      applistItems: applistItems ?? this.applistItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
