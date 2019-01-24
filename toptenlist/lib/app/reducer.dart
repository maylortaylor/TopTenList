import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:toptenlist/app/appState.dart';
import 'package:toptenlist/models/List.dart';

class OnListChangedAction {
  final List<AppList> applists;

  OnListChangedAction(this.applists);
}

class RequestItemDataEventAction {}

class CancelItemDataEventAction {}

class AddItemAction {
  final AppList applists;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  AddItemAction({
    this.applists,
    this.onComplete,
    this.onError,
  });
}

class EditItemAction {
  final AppList applists;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  EditItemAction({
    this.applists,
    this.onComplete,
    this.onError,
  });
}

class RemoveItemAction {
  final AppList applists;
  final VoidCallback onComplete;
  final FutureOr<dynamic> Function(dynamic error) onError;

  RemoveItemAction({
    this.applists,
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
  return state.copyWith(appLists: action.applists);
}

// AppState changeOrderByReducer(AppState state) {
//   final appLists = new List<AppList>.of(state.appLists)..sort(comparator);
//   return state.copyWith(appLists: appLists);
// }
