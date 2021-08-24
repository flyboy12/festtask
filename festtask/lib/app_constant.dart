import 'package:flutter/material.dart';

class AppThemeConstant {
  static Color backgroundColor = Color(0xffeeeeee);
  static Color primaryColor = Color(0xff222831);
  static Color accentColor = Color(0xff393e46);
  static Color thirdColor = Color(0xffffd369);
  static ThemeData theme = ThemeData(
    primaryIconTheme: IconThemeData(color: accentColor, size: 16),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: accentColor)),
    splashColor: accentColor,
    buttonTheme: ButtonThemeData(
      buttonColor: backgroundColor,
      disabledColor: backgroundColor,
    ),
    primaryColorLight: thirdColor,
    backgroundColor: backgroundColor,
    primaryColor: primaryColor,
    accentColor: accentColor,
    iconTheme: IconThemeData(color: accentColor),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
