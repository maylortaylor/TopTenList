import 'package:flutter/material.dart';

final ThemeData appThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: AppColors.appBlue,
  // ? primary color
  primaryColor: const Color(0xFF09A2DD),
  primaryColorDark: AppColors.appBlue[900],
  primaryColorBrightness: Brightness.light,
  // ? accent color
  accentColor: AppColors.appGreen[500],
  accentColorBrightness: Brightness.light,
  errorColor: Colors.redAccent,

  bottomAppBarColor: AppColors.appBlue[500],
  highlightColor: Colors.yellowAccent,
  textSelectionColor: Colors.yellowAccent,
  unselectedWidgetColor: Colors.grey,
  secondaryHeaderColor: Colors.greenAccent,
  dialogBackgroundColor: Colors.grey,
  // ? Define the default Font Family
  fontFamily: 'Montserrat',
  // ? Define the default TextTheme. Use this to specify the default
  // ? text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    subhead: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    title: TextStyle(
        fontSize: 32.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold),
    subtitle: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
    display1: TextStyle(fontSize: 22.0, fontStyle: FontStyle.normal),
    display2: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
    display3: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
    display4: TextStyle(fontSize: 14.0, fontStyle: FontStyle.normal),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
    body2: TextStyle(fontSize: 12.0, fontFamily: 'Montserrat'),
    button: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
  ),
);

class AppColors {
  const AppColors._();

  static const Color appBar = const Color(0xFF09A2DD);
  static const Color appBarBottom = const Color(0xFF5DBFE4);
  static const Color appNavBar = const Color(0xFF32B0E0);
  static const Color appBarTitle = const Color(0xFF32B0E0);
  static const Color appBarIconColor = const Color(0xFFBFFBFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFF3383FC);
  static const Color appBarGradientEnd = const Color(0xFF00C6FF);

  static const Color card = const Color(0xFFDDF1FA);
  static const Color card2 = const Color(0xFF93B3BF);
  static const Color cardFooter = const Color(0xFF5DBFE4);
  static const Color cardDark = Color.fromRGBO(58, 66, 86, 1.0);
  static const Color cardTitle = const Color(0xFFBFFBFF);
  static const Color pageBackground = const Color(0xFFF2F2F2);
  static const Color pageBackgroundDark = Color.fromRGBO(58, 66, 86, 1.0);

  static Color shadow = Colors.lightBlueAccent.shade100;

  static const Color progressIndicatorBackground =
      const Color.fromRGBO(209, 224, 224, 0.2);
  static const Color chartColorOne = const Color(0xFFF5B700);
  static const Color chartColorTwo = const Color(0xFFDC0073);
  static const Color chartColorThree = const Color(0xFF1AA1B6);
  static const Color chartColorFour = const Color(0xFF15AA5B);
  static const Color chartColorFive = const Color(0xFF943300);

  static const Color appWhite = const Color(0xFFF2F2F2);
  static const Color appIconWhite = const Color(0xFFF6F9F9);
  static const Color appBlack = Color.fromRGBO(58, 66, 86, 1.0);
  static const Color appGrey = const Color(0xFF9797A5);
  static const Color appLightGrey = const Color(0xFFE1EEF6);
  static const Color appYellow = const Color(0xFFF9F871);

  static const Color appAccent1 = const Color(0xFF435DE5);
  static const Color appAccent2 = const Color(0xFF038DC2);
  static const Color appAccent3 = const Color(0xFF036388);

  static const Color appError = const Color(0xFF882100);
  static const Color appPriceDown = const Color(0xFFCF0045);
  static const Color appPriceUp = const Color(0xFF009D3A);

  static const MaterialColor appBlue = const MaterialColor(0x1AA1B6, const {
    50: const Color(0xFFD5EDF1),
    100: const Color(0xFFC0E5EB),
    200: const Color(0xFFABDCE4),
    300: const Color(0xFF96D4DD),
    400: const Color(0xFF82CBD7),
    500: const Color(0xFF6DC3D0),
    600: const Color(0xFF58BAC9),
    700: const Color(0xFF43B2C3),
    800: const Color(0xFF2EA9BC),
    900: const Color(0xFF1AA1B6)
  });
  static const MaterialColor appGreen = const MaterialColor(0x1AA1B6, const {
    50: const Color(0xBFECD4),
    100: const Color(0xAAE5C6),
    200: const Color(0x95DFB8),
    300: const Color(0x80D9AA),
    400: const Color(0x6BD39C),
    500: const Color(0x56CC8E),
    600: const Color(0x41C680),
    700: const Color(0x2CC072),
    800: const Color(0x17BA64),
    900: const Color(0x15AA5B)
  });
}

class Dimens {
  const Dimens();

  static const itemWidth = 100.0;
  static const itemHeight = 100.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: AppColors.appWhite,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      fontSize: 36.0);

  static const TextStyle searchTitle = const TextStyle(
      color: AppColors.appWhite,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      fontSize: 22.0);

  static const TextStyle companyPrice = const TextStyle(
      color: AppColors.appWhite,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.normal,
      fontSize: 36.0);

  static const TextStyle sectionTitle = const TextStyle(

      // decoration: TextDecoration.underline,

      color: AppColors.appBlack,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      fontSize: 36.0);
}
