import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// A service that monitors the device's internet connectivity status.
///
/// This service uses [Connectivity] to detect network changes and
/// [InternetConnectionChecker] to verify actual internet connectivity.
/// It provides a reactive [isOnline] variable that can be observed
/// throughout the application to respond to connectivity changes.
class ConnectivityService extends GetxService {
  /// Observable boolean that indicates if the device has an active internet connection.
  ///
  /// This value is updated automatically when connectivity changes are detected.
  /// - `true`: Device has an active internet connection
  /// - `false`: Device has no internet connection
  var isOnline = false.obs;

  /// Initializes the connectivity listener when the service is created.
  ///
  /// Sets up a stream subscription to [Connectivity] changes and updates
  /// the [isOnline] value by checking actual internet connectivity
  /// using [InternetConnectionChecker].
  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((status) async {
      isOnline.value = await InternetConnectionChecker().hasConnection;
    });
  }

  /// Cleans up resources when the service is being closed.
  ///
  /// Sets [isOnline] to false and calls the parent class's onClose method.
  @override
  void onClose() {
    isOnline.value = false;
    super.onClose();
  }
}