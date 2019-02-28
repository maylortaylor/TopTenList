import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:toptenlist/app/appState.dart';
import 'package:toptenlist/models/List.dart';

class OnListChangedAction {
  final List<AppListItem> applistItems;

  OnListChangedAction(this.applistItems);
}

class RequestItemDataEventAction {}

class CancelItemDataEventAction {}

class AddItemAction {
  final AppListItem applistItems;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  AddItemAction({
    this.applistItems,
    this.onComplete,
    this.onError,
  });
}

class EditItemAction {
  final AppListItem applistItems;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  EditItemAction({
    this.applistItems,
    this.onComplete,
    this.onError,
  });
}

class RemoveItemAction {
  final AppListItem applistItems;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  RemoveItemAction({
    this.applistItems,
    this.onComplete,
    this.onError,
  });
}

class RemoveAllItemAction {
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  RemoveAllItemAction({
    this.onComplete,
    this.onError,
  });
}

final appReducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, OnListChangedAction>(onListChangeReducer),
]);

AppState onListChangeReducer(AppState state, OnListChangedAction action) {
  return state.copyWith(applistItems: action.applistItems);
}

// AppState changeOrderByReducer(AppState state) {
//   final appLists = new List<AppList>.of(state.appLists)..sort(comparator);
//   return state.copyWith(appLists: appLists);
// }
