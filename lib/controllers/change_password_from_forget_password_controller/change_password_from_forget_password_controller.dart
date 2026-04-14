import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_glow/routes/app_path.dart';

import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';

/// Change Password From Forget Controller
class ChangePasswordFromForgetController extends GetxController {
  // Dependencies
  final AuthService _authService = AuthService.instance;

  // Text editing controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxString userEmail = ''.obs;
  final RxString otpCode = ''.obs;

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Set the credentials from the previous screen
  void setCredentials(String email, String code) {
    userEmail.value = email;
    otpCode.value = code;
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
    if (newPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter a new password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text.length < 6) {
      Fluttertoast.showToast(
        msg: 'Password must be at least 6 characters',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please confirm your password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
        msg: 'Passwords do not match',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }

  /// Handle save password
  Future<void> onSavePassword(BuildContext context) async {
    if (!_validatePasswords()) return;

    isLoading.value = true;

    try {
      final response = await _authService.confirmPasswordReset(
        email: userEmail.value,
        code: otpCode.value,
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      if (response.success && response.data != null) {
        Fluttertoast.showToast(
          msg: response.data?.detail ?? 'Password reset successfully. You can now log in.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Clear fields
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Once changed, redirect to login
        if (context.mounted) {
          context.go('/login');
        }
      } else {
        Fluttertoast.showToast(
          msg: response.errorMessage ?? 'Failed to reset password. Please try again.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to reset password: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
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