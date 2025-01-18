import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';


class LgDeviceUtils{
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }
  static double getAppBarHeight() {
    return kToolbarHeight;
  }
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }
}