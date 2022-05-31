import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasa_app/bindings/base_binding.dart';
import 'package:nasa_app/view/home_page.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: Routes.homeScreen,
      initialBinding: BaseBinding(),
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
    );
  }
}
