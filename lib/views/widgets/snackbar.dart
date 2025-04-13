import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  /// Displays a snackbar notification using GetX.
  ///
  /// This method shows a snackbar with the provided title and message.
  /// The text color is set to the current theme's highlight color.
  ///
  /// Parameters:
  /// - [title]: The title text to be displayed in the snackbar.
  /// - [message]: The message content to be displayed in the snackbar.
  ///
  /// Returns void.
  static void showSnackbar(String title, String message) {
    final theme = Theme.of(Get.context!);
    Get.snackbar(
      title,
      message,
      colorText: theme.highlightColor
    );
  }
}
