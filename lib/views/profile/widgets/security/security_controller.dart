import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_path.dart';
import 'delete_account_dialog.dart';

/// Security Controller - Manages security settings state
class SecurityController extends GetxController {
  // Observable states for security settings
  final RxBool loginActivity = true.obs;
  final RxBool emailPhoneVerification = true.obs;
  final RxBool isDeleting = false.obs;

  /// Toggle login activity
  void toggleLoginActivity(bool value) {
    loginActivity.value = value;
    // TODO: Save to local storage or API
  }

  /// Toggle email & phone verification
  void toggleEmailPhoneVerification(bool value) {
    emailPhoneVerification.value = value;
    // TODO: Save to local storage or API
  }

  /// Handle change password tap
  void onChangePasswordTap(BuildContext context) {
    // Navigate to change password screen using GoRouter
    context.push(AppPath.changePassword);
  }

  /// Handle delete account tap
  void onDeleteAccountTap(BuildContext context) {
    // Show delete account confirmation dialog
    DeleteAccountDialog.show(
      context,
      onConfirmDelete: () => _performDeleteAccount(context),
    );
  }

  /// Perform account deletion
  Future<void> _performDeleteAccount(BuildContext context) async {
    isDeleting.value = true;

    try {
      // TODO: Implement API call to delete account
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      Get.snackbar(
        'Success',
        'Account deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFED6B61),
        colorText: Colors.white,
      );

      // Navigate to login screen after deletion
      if (context.mounted) {
        context.go(AppPath.login);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}
