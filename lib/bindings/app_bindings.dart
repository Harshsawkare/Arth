import 'package:get/get.dart';

import '../controllers/news_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/theme_controller.dart';
import '../services/connectivity_service.dart';

/// A binding class that registers controllers and services for dependency injection.
///
/// This class implements the [Bindings] interface from the GetX package and is responsible
/// for initializing and registering all the necessary controllers and services
/// when the application starts or when a specific route is accessed.
class AppBindings extends Bindings {
  /// Registers all dependencies for the application.
  ///
  /// This method is called automatically by the GetX framework when the binding is initialized.
  /// It registers the following dependencies:
  /// - [NewsController]: Manages news data and operations
  /// - [SearchBoxController]: Handles search functionality
  /// - [ThemeController]: Manages application theme settings
  /// - [ConnectivityService]: Monitors network connectivity status
  ///
  /// All dependencies are registered using lazy initialization, meaning they will only
  /// be created when first accessed.
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<SearchBoxController>(() => SearchBoxController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<ConnectivityService>(() => ConnectivityService());
  }
}