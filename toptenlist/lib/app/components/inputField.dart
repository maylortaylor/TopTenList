import 'package:toptenlist/theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  IconData icon;
  String hintText;
  TextInputType textInputType;
  Color textFieldColor, iconColor;
  bool obscureText;
  var validateFunction;
  var onSaved;
  bool autoFocus;
  String initialValue;

  String onEmpty;
  String name;

  //passing props in the Constructor.
  //Java like style
  InputField(
      {this.name,
      this.hintText,
      this.onEmpty,
      this.obscureText = false,
      this.textInputType,
      this.icon,
      this.validateFunction,
      this.onSaved,
      this.autoFocus = false,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.only(bottom: 10.0),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            color: AppColors.appLightGrey),
        child: new Padding(
          padding: EdgeInsets.all(5.0),
          child: new TextFormField(
            autofocus: autoFocus,
            initialValue: initialValue,
            style: appThemeData.textTheme.display1,
            decoration: new InputDecoration(
              labelStyle: appThemeData.textTheme.title,
              icon: new Icon(icon),
              labelText: name,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: AppColors.appGrey, fontSize: 15.0),
            ),
            validator: (val) => val.isEmpty ? onEmpty : null,
            onSaved: (val) => onSaved = val,
            obscureText: obscureText,
            keyboardType: textInputType,
          ),
        ),
      ),
    ));
  }
}
