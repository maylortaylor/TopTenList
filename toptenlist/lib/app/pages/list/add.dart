import 'dart:async';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:toptenlist/app/components/inputField.dart';
import 'package:toptenlist/app/components/loginButton.dart';
import 'package:toptenlist/app/components/textButton.dart';
import 'package:toptenlist/models/List.dart';
import 'package:toptenlist/theme.dart';
import 'package:flutter/material.dart';

class AddListComponent extends StatefulWidget {
  @override
  _AddListComponentState createState() => new _AddListComponentState();
}

class _AddListComponentState extends State<AddListComponent>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animController;
  List<AppListItem> _applistItems = [];

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 0.0, end: 62.0).animate(animController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add a new list')),
        body: TextField(
          autofocus: true,
          onSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context); // Close the add todo screen
          },
          decoration: InputDecoration(
              hintText: 'List name...',
              contentPadding: const EdgeInsets.all(16.0)),
        ));
  }

  void _addTodoItem(val) {
    print(val);
    setState(() {
      int index = _applistItems.length;
      AppListItem newAppListItem = AppListItem(
          id: '1', title: val, creator: '', description: '', url: '');
      _applistItems.add(newAppListItem);
    });
  }
}
