import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app_with_database/View/Category%20Page/category.dart';
import 'package:quote_app_with_database/View/Theme%20Page/Theme.dart';

import 'Controller/controller.dart';
import 'Database/database.dart';
import 'View/Home Page/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(QuotesController());

  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/theme', page: () => ThemePage()),
        GetPage(name: '/cat', page: () => CategoryPage(),)
      ],
    );
  }
}
