import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/screens/home/view/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      getPages: [
        GetPage(name: '/', page: () => Home()),
      ],
    ),
  );
}
