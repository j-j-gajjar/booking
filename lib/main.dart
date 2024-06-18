import 'package:booking/navigation/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Booking',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    );
  }
}
