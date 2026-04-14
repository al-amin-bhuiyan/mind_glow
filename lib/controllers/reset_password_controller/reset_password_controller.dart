import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';
import '../../services/auth_service.dart';

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

      final email = emailController.text.trim();
      final response = await AuthService.instance.sendPasswordResetOtp(email: email);

      if (response.success) {
        Fluttertoast.showToast(
          msg: response.data?.detail ?? 'OTP sent to email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Navigate to OTP verification screen with email and isPasswordReset flag
        if (context.mounted) {
          context.push(AppPath.otpVerification, extra: {
            'email': email,
            'isPasswordReset': true,
          });
          emailController.clear();
        }
      } else {
        Fluttertoast.showToast(
          msg: response.errorMessage ?? 'Failed to send reset code. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
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