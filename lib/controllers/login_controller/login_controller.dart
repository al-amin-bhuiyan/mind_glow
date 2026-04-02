import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../routes/app_path.dart';

/// Login Controller - Manages login screen state and logic
class LoginController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController emailController = TextEditingController(text: 'md@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'afasdfasdfasd');

  // Observable states
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool rememberMe = false.obs;

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
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// Navigate to Forgot Password screen
  void navigateToForgotPassword(BuildContext context) {
    context.push(AppPath.resetPassword);
  }

  /// Validate email in real-time
  void _validateEmail() {
    isEmailValid.value = _emailRegex.hasMatch(emailController.text);
  }

  /// Validate form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Password validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(BuildContext context) async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Implement actual sign-in logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // Show success toast
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Login successful!'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );

      // Navigate to inner connection page after successful login
      if (context.mounted) {
        context.push(AppPath.home);
      }

    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Error'),
        description: Text('Login failed: ${e.toString()}'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading.value = true;

      // TODO: Implement Google Sign-in logic
      await Future.delayed(const Duration(seconds: 2));

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Google sign-in successful!'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );

    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Error'),
        description: Text('Google sign-in failed: ${e.toString()}'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    try {
      isLoading.value = true;

      // TODO: Implement Apple Sign-in logic
      await Future.delayed(const Duration(seconds: 2));

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Apple sign-in successful!'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );

    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Error'),
        description: Text('Apple sign-in failed: ${e.toString()}'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate to Sign Up screen
  void navigateToSignUp(BuildContext context) {
    context.push(AppPath.signup);
  }
}
