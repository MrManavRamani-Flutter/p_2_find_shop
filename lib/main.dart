import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/controllers/shop_controller.dart';

import 'controllers/theme_controller.dart';
import 'theme/app_theme.dart'; // Import the AppTheme class to access light and dark themes
import 'views/home_view.dart';

void main() {
  Get.put(ThemeController()); // Register ThemeController
  Get.put(ShopController()); // Register ThemeController
  runApp(const DigitalJasdanApp());
}

class DigitalJasdanApp extends StatelessWidget {
  const DigitalJasdanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Jasdan',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: HomeView(),
    );
  }
}
