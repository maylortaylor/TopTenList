import 'dart:async';

import 'package:toptenlist/app/components/inputField.dart';
import 'package:toptenlist/app/components/loginButton.dart';
import 'package:toptenlist/app/components/textButton.dart';
import 'package:toptenlist/theme.dart';
import 'package:flutter/material.dart';
import 'package:toptenlist/models/user.dart';
import 'package:toptenlist/app/pages/login/loginService.dart';

class LoginComponent extends StatefulWidget {
  @override
  _LoginComponentState createState() => new _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent>
    with SingleTickerProviderStateMixin
    implements LoginPageContract {
  Timer _timer;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  Animation<double> animation;
  AnimationController animController;
  final double maxRadiusSize = 62.0;

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginComponentState() {
    _presenter = new LoginPagePresenter(this);
  }
  @override
  void dispose() {
    animController.dispose();
    _timer.cancel();

    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
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
    final logoAndTagLine = Center(
      child: Column(
        children: <Widget>[
          // CircleAvatar(
          //   backgroundColor: Colors.transparent,
          //   radius: 62.0,
          //   child: Image.asset('assets/images/pocketpiggly.png'),
          // ),
          Text("Top Ten List",
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold))
        ],
      ),
    );

    final email = InputField(
        textInputType: TextInputType.emailAddress,
        autoFocus: false,
        initialValue: 'neonmusk@gmail.com',
        hintText: 'Email');

    final password = InputField(
        autoFocus: false,
        initialValue: 'somepassword',
        obscureText: true,
        hintText: 'Password');

    final loginButton = LoginButton(
        buttonText: 'Log In',
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        });

    final forgotLabel = TextButton(text: 'Forgot password?', onPressed: () {});

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logoAndTagLine,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(UserModel user) async {
    _showSnackBar(user.toString());

    _timer = new Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _isLoading = false;
        // Navigator.of(context).pushNamed("/grid");
      });
    });
  }
}
