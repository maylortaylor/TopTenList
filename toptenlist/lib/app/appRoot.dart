import 'package:redux/redux.dart';
import 'package:toptenlist/app/appState.dart';
import 'package:toptenlist/app/middleware.dart';
import 'package:toptenlist/app/pages/home/homeComponent.dart';
import 'package:toptenlist/app/pages/login/loginComponent.dart';
import 'package:toptenlist/app/reducer.dart';
import 'package:toptenlist/theme.dart' as Theme;
import 'package:flutter/material.dart';

class AppRootWidget extends StatefulWidget {
  @override
  AppRootWidgetState createState() => new AppRootWidgetState();
}

class AppRootWidgetState extends State<AppRootWidget> {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.initialState(),
    middleware: createMiddleWares(),
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Top Ten List',
      // debugShowMaterialGrid: false,
      // debugShowCheckedModeBanner: false,
      theme: Theme.appThemeData,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomeComponent(),
        '/login': (BuildContext context) => LoginComponent(),
      },
    );
  }
}
