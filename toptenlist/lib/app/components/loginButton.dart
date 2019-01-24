import 'package:toptenlist/theme.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  VoidCallback onPressed;
  String buttonText;

  //passing props in the Constructor.
  //Java like style
  LoginButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return (new Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: AppColors.shadow,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: onPressed,
          color: appThemeData.primaryColor,
          child: Text(buttonText,
              style: TextStyle(fontSize: 24.0, color: AppColors.appWhite)),
        ),
      ),
    ));
  }
}
