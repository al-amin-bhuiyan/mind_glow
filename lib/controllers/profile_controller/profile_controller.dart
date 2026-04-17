import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routes/app_path.dart';
import '../../views/profile/widgets/logout_dialog.dart';
import '../../services/auth_state_service.dart';
import '../../services/token_storage_service.dart';
import '../../services/session_data_isolation_service.dart';
import '../../services/auth_service.dart';
import '../home_controller/home_controller.dart';
import '../reflect_controller/reflect_controller.dart';

/// Controller for Profile Screen - handles profile actions and navigation
class ProfileController extends GetxController {
  // Observable states
  final RxBool isLoading = true.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load user data
    _loadUserData();
  }

  /// Load user data
  Future<void> _loadUserData({bool showLoading = true}) async {
    try {
      if (showLoading) isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await AuthService.instance.getUserProfile(token: token);

      if (response.success && response.data != null) {
        final data = response.data!;
        userName.value = data.fullName;
        userEmail.value = data.email;
        userImage.value = data.profilePicture ?? '';
        
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().updateUserName(data.fullName);
        }
        
        if (Get.isRegistered<ReflectController>()) {
          Get.find<ReflectController>().userProfilePicture.value = data.profilePicture ?? '';
        }
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  /// Handle Edit Profile tap
  Future<void> onEditProfileTap(BuildContext context) async {
    // Navigate to edit profile screen with current user data using GoRouter
    await context.push(
      AppPath.editProfile,
      extra: {
        'email': userEmail.value,
        'full_name': userName.value,
        'profile_picture': userImage.value,
      },
    );
    // Reload user data silently when returning
    await _loadUserData(showLoading: false);
  }

  /// Handle Subscription tap
  void onSubscriptionTap(BuildContext context) {
    // Navigate to subscription screen using GoRouter
    context.push(AppPath.subscription);
  }

  /// Handle Notification tap
  void onNotificationTap(BuildContext context) {
    // Navigate to notification screen using GoRouter
    context.push(AppPath.notification);
  }

  /// Handle Security tap
  void onSecurityTap(BuildContext context) {
    // Navigate to security screen using GoRouter
    context.push(AppPath.security);
  }

  /// Handle Support & Help tap
  void onSupportHelpTap(BuildContext context) {
    // Navigate to support and help screen using GoRouter
    context.push(AppPath.supportAndHelp);
  }

  /// Handle Logout tap
  void onLogoutTap(BuildContext context) {
    _showLogoutDialog(context);
  }

  /// Handle Logout button press
  void onLogoutButtonPress(BuildContext context) {
    _showLogoutDialog(context);
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) {
        return LogoutDialog(
          onLogoutConfirm: () => _handleLogout(context),
        );
      },
    );
  }

  /// Handle logout confirmation
  Future<void> _handleLogout(BuildContext context) async {
    // Close the dialog
    Navigator.of(context).pop();

    try {
      debugPrint('🚀 Starting logout process');
      await TokenStorageService.instance.clearAll();
      SessionDataIsolationService.instance.clearUserScopedState();
      AuthStateService.instance.setUnauthenticated();
      debugPrint('✅ Logout successful');

      // Navigate to login screen using GoRouter
      if (context.mounted) context.go(AppPath.login);
    } catch (e) {
      debugPrint('❌ Logout failed: $e');
      if (context.mounted) {
        Fluttertoast.showToast(
          msg: 'Logout failed. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  /// Handle back button press
  void goBack(BuildContext context) {
    context.pop();
  }
}