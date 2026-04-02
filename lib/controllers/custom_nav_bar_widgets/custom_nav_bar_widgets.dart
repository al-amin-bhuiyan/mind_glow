import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';

/// Controller for Navigation Bar - handles bottom navigation
/// Uses OOP principles with clean separation of concerns
class CustomNavBarController extends GetxController {
  // Observable for the current selected index
  var selectedIndex = 0.obs;

  // Track if navigation is in progress to prevent white flick
  var isNavigating = false.obs;

  /// Method to change the selected index and navigate
  /// Uses custom transition to eliminate white flick
  void changeIndex(int index, BuildContext context) {
    // Prevent multiple navigation calls
    if (isNavigating.value) return;

    // Don't navigate if already on the same page
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;
    isNavigating.value = true;

    // Use go instead of push to avoid stacking pages
    // This prevents white flick by replacing the route
    final targetRoute = _getRouteForIndex(index);

    // Navigate with no animation to prevent white flick
    context.go(targetRoute);

    // Reset navigation flag after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      isNavigating.value = false;
    });
  }

  /// Get route path for given index
  /// Private method following OOP encapsulation
  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return AppPath.home;
      case 1:
        return AppPath.reflect;
      case 2:
        return AppPath.journey;
      case 3:
        return AppPath.inspire;
      case 4:
        return AppPath.innerLearning;
      default:
        return AppPath.home;
    }
  }

  /// Method to get the current route based on index
  String getCurrentRoute() {
    return _getRouteForIndex(selectedIndex.value);
  }

  /// Check if a specific tab is selected
  bool isSelected(int index) => selectedIndex.value == index;
}
