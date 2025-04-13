import 'package:arth_ai/bindings/app_bindings.dart';
import 'package:arth_ai/views/home_scaffold.dart';
import 'package:arth_ai/views/news_details_scaffold.dart';
import 'package:arth_ai/views/splash_screen_scaffold.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Constants.splashScreen,
      page: () => const SplashScreenScaffold(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Constants.homeScreen,
      page: () => const HomeScaffold(),
    ),
    GetPage(
      name: Constants.newsDetailsScreen,
      page: () => const NewsDetailsScaffold(),
    ),
  ];
}
