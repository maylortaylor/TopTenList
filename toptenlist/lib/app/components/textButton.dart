import 'package:toptenlist/theme.dart';
import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;

  //passing props in the Constructor.
  //Java like style
  TextButton({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      child: new Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.appBlack,
              fontSize: 14.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold)),
      onPressed: onPressed,
    ));
  }
}
