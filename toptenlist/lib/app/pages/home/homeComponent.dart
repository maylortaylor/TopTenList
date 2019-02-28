import 'dart:async';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:toptenlist/app/pages/list/add.dart';
import 'package:toptenlist/app/pages/list/appListWidget.dart';
import 'package:flutter/material.dart';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => new _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animController;

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
      body: Builder(
        builder: (context) => SliverFab(
              floatingWidget: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddListComponent())),
                child: Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 5.0, color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
              floatingPosition: FloatingPosition(right: 26),
              expandedHeight: 256.0,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 256.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Top Ten List"),
                    background: Image.asset(
                      "assets/images/list-logo.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AppListWidget()
                // SliverList(
                //   delegate: SliverChildListDelegate(
                //     List.generate(
                //       30,
                //       (int index) => ListTile(title: Text("Item $index")),
                //     ),
                //   ),
                // ),
              ],
            ),
      ),
    );
  }
}
