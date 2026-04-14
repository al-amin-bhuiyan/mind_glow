import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_service.dart';
import '../../services/inspiration_service.dart';
import '../../services/reflect_service.dart';
import '../../services/token_storage_service.dart';
import '../reflect_controller/reflect_controller.dart';

/// Controller for Home Screen - handles home page logic
class HomeController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userName = ''.obs;

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
    // Just navigate to reflections blob screen, wait for user input to create session
    final reflectController = Get.find<ReflectController>();
    reflectController.currentConversationId = null;
    reflectController.messages.clear();
    context.push(AppPath.reflectblob);
  }

  /// Handle start session button tap
  void onStartSession(BuildContext context) async {
    isLoading.value = true;

    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final reflectController = Get.find<ReflectController>();

      // 1. Get the last conversation ID
      final lastConvResponse = await ReflectService.instance.getLastConversation(token: token ?? '');
      
      bool success = false;
      
      if (lastConvResponse.success && lastConvResponse.data != null && lastConvResponse.data!['conversation_id'] != null) {
        final int conversationId = lastConvResponse.data!['conversation_id'];
        
        // 2. Load the existing conversation history
        success = await reflectController.loadExistingConversation(conversationId);
      } else {
        // Fallback: start a completely new conversation if no previous session is found
        success = await reflectController.startNewConversation();
      }

      isLoading.value = false;

      // Only navigate if we successfully loaded/started the conversation state
      if (success) {
        context.push(AppPath.reflect);
      }
      
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error starting session: $e');
    }
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
    _fetchUserSummary();
    _fetchDailyQuote();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await AuthService.instance.getUserProfile(token: token);

      if (response.success && response.data != null) {
        if (response.data!.fullName.isNotEmpty) {
          updateUserName(response.data!.fullName);
        }
      }
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
    }
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