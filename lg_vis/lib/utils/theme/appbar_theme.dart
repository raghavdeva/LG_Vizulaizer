import 'package:flutter/material.dart';

class LgAppbarTheme{
  LgAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 28),
    actionsIconTheme: IconThemeData(color : Colors.black, size:28),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color:Colors.black),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 28),
    actionsIconTheme: IconThemeData(color : Colors.white, size:28),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color:Colors.white),
  );
}