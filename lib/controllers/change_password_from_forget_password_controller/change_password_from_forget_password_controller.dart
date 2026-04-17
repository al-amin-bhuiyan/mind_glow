import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_glow/routes/app_path.dart';
import 'package:mind_glow/l10n/app_localizations.dart';

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
  bool _validatePasswords(BuildContext context) {
    if (newPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: _getLocalized(context, 'errorEmptyNewPassword', 'Please enter a new password'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text.length < 6) {
      Fluttertoast.showToast(
        msg: _getLocalized(context, 'errorShortPassword', 'Password must be at least 6 characters'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: _getLocalized(context, 'errorEmptyConfirmPassword', 'Please confirm your password'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
        msg: _getLocalized(context, 'errorPasswordMismatch', 'Passwords do not match'),
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
    if (!_validatePasswords(context)) return;

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
          msg: response.data?.detail ?? _getLocalized(context, 'successPasswordReset', 'Password reset successful. You can now log in.'),
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
          msg: response.errorMessage ?? _getLocalized(context, 'errorPasswordResetFailed', 'Failed to reset password. Please try again.'),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '${_getLocalized(context, 'errorPasswordResetPrefix', 'Reset failed: ')}${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _getLocalized(BuildContext context, String key, String fallback) {
    try {
      final localizations = AppLocalizations.of(context) as dynamic;
      switch (key) {
        case 'errorEmptyNewPassword': return localizations.errorEmptyNewPassword;
        case 'errorShortPassword': return localizations.errorShortPassword;
        case 'errorEmptyConfirmPassword': return localizations.errorEmptyConfirmPassword;
        case 'errorPasswordMismatch': return localizations.errorPasswordMismatch;
        case 'successPasswordReset': return localizations.successPasswordReset;
        case 'errorPasswordResetFailed': return localizations.errorPasswordResetFailed;
        case 'errorPasswordResetPrefix': return localizations.errorPasswordResetPrefix;
        default: return fallback;
      }
    } catch (_) {
      return fallback;
    }
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}