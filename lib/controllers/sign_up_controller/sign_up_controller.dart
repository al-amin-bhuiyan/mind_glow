import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../routes/app_path.dart';

/// SignUp Controller - Manages sign up screen state and logic
class SignUpController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController fullNameController = TextEditingController(text: 'Mohammad Shobuj');
  final TextEditingController emailController = TextEditingController(text: 'md@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '123456');
  final TextEditingController confirmPasswordController = TextEditingController(text: '123456');

  // Observable states
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool isFullNameValid = false.obs;

  // Email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void onInit() {
    super.onInit();
    // Listen to field changes for real-time validation
    emailController.addListener(_validateEmail);
    fullNameController.addListener(_validateFullName);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Validate email in real-time
  void _validateEmail() {
    isEmailValid.value = _emailRegex.hasMatch(emailController.text);
  }

  /// Validate full name in real-time
  void _validateFullName() {
    isFullNameValid.value = fullNameController.text.trim().length >= 2;
  }

  /// Validate form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Full name validator
  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
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

  /// Confirm password validator
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail(BuildContext context) async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Implement actual sign-up logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // Show success toast
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Sign up successful!'),
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );

      // Navigate to inner connection page after successful signup
      if (context.mounted) {
        context.push(AppPath.innerConnection);
      }

    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Error'),
        description: Text('Sign up failed: ${e.toString()}'),
        alignment: Alignment.bottomCenter,
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

  /// Sign up with Google
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      isLoading.value = true;

      // TODO: Implement Google Sign-up logic
      await Future.delayed(const Duration(seconds: 2));

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Google sign-up successful!'),
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
        description: Text('Google sign-up failed: ${e.toString()}'),
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

  /// Sign up with Apple
  Future<void> signUpWithApple(BuildContext context) async {
    try {
      isLoading.value = true;

      // TODO: Implement Apple Sign-up logic
      await Future.delayed(const Duration(seconds: 2));

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text('Apple sign-up successful!'),
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
        description: Text('Apple sign-up failed: ${e.toString()}'),
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

  /// Navigate to Sign In screen
  void navigateToSignIn(BuildContext context) {
    context.pop();
  }
}
