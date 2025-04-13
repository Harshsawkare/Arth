import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_theme.dart';

/// A controller class that manages the application's theme state.
///
/// This controller handles toggling between light and dark themes,
/// persisting theme preferences, and loading saved theme preferences
/// when the application starts.
class ThemeController extends GetxController {
  /// Observable boolean that tracks the current theme mode.
  ///
  /// `true` indicates dark mode is active, `false` indicates light mode.
  var isDarkMode = false.obs;

  @override
  /// Initializes the controller.
  ///
  /// Calls the parent's onInit method and loads the saved theme preference.
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }

  /// Toggles between light and dark themes.
  ///
  /// Inverts the current theme mode, updates the application's theme,
  /// and persists the new theme preference.
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
    saveThemeToPreferences(isDarkMode.value);
  }

  /// Loads the saved theme preference from local storage.
  ///
  /// Retrieves the theme preference from SharedPreferences and
  /// applies it to the application. If no preference is found,
  /// defaults to light mode (isDarkMode = false).
  void loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }

  /// Saves the current theme preference to local storage.
  ///
  /// [isDarkMode] - Boolean indicating whether dark mode is active.
  void saveThemeToPreferences(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  /// Cleans up resources when the controller is removed.
  ///
  /// Resets the theme mode to light and calls the parent's onClose method.
  void onClose() {
    isDarkMode.value = false;
    super.onClose();
  }
}
