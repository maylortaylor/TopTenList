import 'package:flutter/material.dart';
import 'package:toptenlist/models/list.dart';

class AppListWidget extends StatefulWidget {
  @override
  createState() => new AppListState();
}

class AppListState extends State<AppListWidget> {
  List<AppListItem> _appListItems = [];

  // This will be called each time the + button is pressed
  void _addListItem() {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    int index = _appListItems.length;
    var newItem = AppListItem(
        title: 'List Item ' + index.toString(),
        creator: null,
        description: null,
        id: null,
        url: null);

    setState(() {
      _appListItems.add(newItem);
    });
  }

  // Build the whole list of todo items
  Widget _buildAppList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _appListItems.length) {
          return _buildAppListItem(_appListItems[index]);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildAppListItem(AppListItem listItem) {
    return new ListTile(title: new Text(listItem.title));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('App List')),
      body: _buildAppList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addListItem,
          tooltip: 'Add item',
          child: new Icon(Icons.add)),
    );
  }
}
