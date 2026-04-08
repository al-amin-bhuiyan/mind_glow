import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_service.dart';
import '../../services/inspiration_service.dart';
import '../../services/token_storage_service.dart';

/// Controller for Home Screen - handles home page logic
class HomeController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userName = 'Emma'.obs;

  // New states for User Summary
  final RxInt reflectionsCount = 0.obs;
  final RxInt learningsCount = 0.obs;
  final RxInt activeReflectionDays = 0.obs;

  /// Daily quote
  final RxString dailyQuote = ''.obs;
  final RxString quoteAuthor = ''.obs;
  
  // ==================== Public Methods ====================

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
    _fetchUserSummary();
    _fetchDailyQuote();
  }

  Future<void> _fetchDailyQuote() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InspirationService.instance.getDailyQuote(token: token);

      if (response.success && response.data != null) {
        if(response.data!.quote.isNotEmpty) {
          dailyQuote.value = response.data!.quote;
          quoteAuthor.value = response.data!.author;
        }
      }
    } catch (e) {
      debugPrint('Error fetching daily quote: $e');
    }
  }

  Future<void> _fetchUserSummary() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await AuthService.instance.getUserSummary(token: token);

      if (response.success && response.data != null) {
        reflectionsCount.value = response.data!.reflectionsCount;
        learningsCount.value = response.data!.learningsCount;
        activeReflectionDays.value = response.data!.activeReflectionDays;
      }
    } catch (e) {
      debugPrint('Error fetching user summary: $e');
    }
  }
}