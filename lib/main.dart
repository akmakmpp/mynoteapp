import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page/home_page.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.orange),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.orange)),
      initialRoute: '/home',
      getPages: MyRoutes.routes,
    );
  }
}
