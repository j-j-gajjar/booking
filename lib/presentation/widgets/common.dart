import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin class CommonMethod {
  void showSnack({String title = 'Error', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade500,
      colorText: Colors.white,
    );
  }
}
