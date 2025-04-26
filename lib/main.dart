import 'package:arth_ai/routes/app_pages.dart';
import 'package:arth_ai/services/local_db_repository.dart';
import 'package:arth_ai/utils/app_theme.dart';
import 'package:arth_ai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'controllers/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Constants.envFileName);
  await Hive.initFlutter();
  await LocalDbRepository().initialize();

  // Initialize ThemeController before runApp
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: lightTheme.copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.blue.withOpacity(0.3), // More visible light blue highlight
            selectionHandleColor: Colors.blue[700], // Darker blue handle
            cursorColor: Colors.blue[700], // Cursor color
          ),
        ),
        darkTheme: darkTheme.copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.cyanAccent.withOpacity(0.3), // More visible cyan highlight
            selectionHandleColor: Colors.cyan[600], // Adjusted handle color
            cursorColor: Colors.cyan[600], // Adjusted cursor color
          ),
        ),
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        getPages: AppPages.routes,
        initialRoute: Constants.splashScreen,
      );
    });
  }
}
