import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';
import '../../views/profile/widgets/logout_dialog.dart';
import '../../services/auth_state_service.dart';
import '../../services/token_storage_service.dart';
import '../../services/session_data_isolation_service.dart';
import '../../widgets/custom_snackbar.dart';

/// Controller for Profile Screen - handles profile actions and navigation
class ProfileController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userName = 'Emma Wilson'.obs;
  final RxString userEmail = 'emma.wilson@gmail.com'.obs;
  final RxString userImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load user data
    _loadUserData();
  }

  /// Load user data
  void _loadUserData() {
    // TODO: Implement user data loading from local storage or API
    // For now, using demo data
  }

  /// Handle Edit Profile tap
  void onEditProfileTap(BuildContext context) {
    // Navigate to edit profile screen with current user data using GoRouter
    context.push(
      AppPath.editProfile,
      extra: {
        'email': userEmail.value,
        'firstName': _getFirstName(),
        'lastName': _getLastName(),
        'imagePath': userImage.value,
      },
    );
  }

  /// Get first name from full name
  String _getFirstName() {
    final nameParts = userName.value.split(' ');
    return nameParts.isNotEmpty ? nameParts[0] : '';
  }

  /// Get last name from full name
  String _getLastName() {
    final nameParts = userName.value.split(' ');
    return nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
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
        CustomSnackBar.showError(
          context,
          message: 'Logout failed. Please try again.',
        );
      }
    }
  }

  /// Handle back button press
  void goBack(BuildContext context) {
    context.pop();
  }
}