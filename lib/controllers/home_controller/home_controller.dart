import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_path.dart';

/// Controller for Home Screen - handles home page logic
class HomeController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userName = 'Emma'.obs;

  /// Handle start reflections button tap
  void onStartReflections(BuildContext context) {
    // Navigate to reflections blob screen with animation
    context.push(AppPath.reflectblob);
  }

  /// Handle start session button tap
  void onStartSession(BuildContext context) {
    // Navigate to reflections blob screen with animation
    context.push(AppPath.reflectblob);
  }

  /// Update user name
  void updateUserName(String name) {
    userName.value = name;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize data
    _loadUserData();
  }

  void _loadUserData() {
    // TODO: Load user data from API or local storage
    userName.value = 'Emma';
  }
}
