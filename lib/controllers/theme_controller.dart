import 'package:get/get.dart';
import 'package:p_2_find_shop/theme/app_theme.dart';

class ThemeController extends GetxController {
  // Initial theme is light mode
  RxBool isDarkMode = false.obs;

  // Toggle between light and dark themes
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // Change the system theme using the themes from AppTheme
    Get.changeTheme(
      isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme,
    );
  }
}
