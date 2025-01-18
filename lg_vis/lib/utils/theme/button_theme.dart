import 'package:flutter/material.dart';

class LgButtonTheme{
  LgButtonTheme._();

  static final lightbutton = ButtonThemeData(
    buttonColor: Color(0xFF2A9D8F),
  );

  static final lightButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF2A9D8F),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      //side : const BorderSide(color: Colors.white),
      fixedSize: Size(150, 60),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),

    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF1C3A3E),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      //side : const BorderSide(color: Colors.blue),
      fixedSize: Size(150, 60),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    )
  );
}