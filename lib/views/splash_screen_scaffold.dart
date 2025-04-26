import 'package:arth_ai/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A splash screen widget that displays the app logo for a brief period before
/// automatically navigating to the home screen.
///
/// This widget creates a full-screen container with the app logo centered,
/// and automatically transitions to the home screen after a fixed delay.
class SplashScreenScaffold extends StatefulWidget {
  /// Creates a splash screen with the app logo.
  ///
  /// The [key] parameter is optional and is passed to the parent class.
  const SplashScreenScaffold({super.key});

  @override
  State<SplashScreenScaffold> createState() => _SplashScreenScaffoldState();
}

class _SplashScreenScaffoldState extends State<SplashScreenScaffold> {
  /// Initializes the state and sets up the automatic navigation.
  ///
  /// This method is called when this object is inserted into the tree.
  /// It schedules a delayed navigation to the home screen after 2 seconds.
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(Constants.homeScreen);
    });
  }

  /// Builds the splash screen UI.
  ///
  /// Creates a full-screen container with the app logo centered.
  ///
  /// @param context The build context for this widget.
  /// @return A Container widget representing the splash screen.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Image.asset(Constants.logoPath, width: 100,),
      ),
    );
  }
}
