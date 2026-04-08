import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../services/auth_service.dart';
import '../../../../../../services/token_storage_service.dart';

/// Change Password Controller - Manages password change functionality
class ChangePasswordController extends GetxController {
  // Dependencies
  final AuthService _authService = AuthService.instance;

  // Text editing controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  final RxBool isCurrentPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle current password visibility
  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  /// Toggle new password visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Validate password fields
  bool _validatePasswords() {
    if (currentPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your current password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a new password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please confirm your password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  /// Handle save password
  Future<void> onSavePassword() async {
    if (!_validatePasswords()) return;

    isLoading.value = true;

    try {
      final token = await TokenStorageService.instance.getAccessToken();

      final response = await _authService.changePassword(
        oldPassword: currentPasswordController.text.trim(),
        newPassword1: newPasswordController.text.trim(),
        newPassword2: confirmPasswordController.text.trim(),
        token: token,
      );

      if (response.success && response.data != null) {
        Get.snackbar(
          'Success',
          response.data!.detail,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Navigate back
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage ?? 'Failed to change password',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}