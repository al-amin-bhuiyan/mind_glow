import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';

/// Reset Password Controller - Manages reset password screen state and logic
class ResetPasswordController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController emailController = TextEditingController(text: 'md@gmail.com');

  // Observable states
  final RxBool isEmailValid = false.obs;
  final RxBool isLoading = false.obs;

  // Email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void onInit() {
    super.onInit();
    // Listen to email changes for real-time validation
    emailController.addListener(_validateEmail);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  /// Validate email in real-time
  void _validateEmail() {
    isEmailValid.value = _emailRegex.hasMatch(emailController.text);
  }

  /// Email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Send reset code
  Future<void> sendResetCode(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement your password reset logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // Navigate to OTP verification screen with email
      if (context.mounted) {
        context.push(AppPath.otpVerification, extra: {'email': emailController.text});
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset code. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate back to login
  void navigateToLogin(BuildContext context) {
    context.pop();
  }
}
