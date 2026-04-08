import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../routes/app_path.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_snackbar.dart';

/// SignUp Controller - Manages sign up screen state and logic
class SignUpController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable states
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEmailValid = false.obs;

  // Dependency
  final AuthService _authService = AuthService.instance;

  // Email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void onInit() {
    super.onInit();
    // Listen to field changes for real-time validation
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

  /// Sign up with email and password
  Future<void> signUpWithEmail(BuildContext context) async {
    debugPrint('🚀 [SignUpController] signUpWithEmail triggered!');
    if (!validateForm()) {
      debugPrint('⛔ [SignUpController] Form validation failed, aborting signup');
      return;
    }

    try {
      isLoading.value = true;
      final String email = emailController.text.trim();
      final String password = passwordController.text;
      debugPrint('📧 [SignUpController] Attempting signup with email: $email');

      final response = await _authService.signup(
        email: email,
        password: password,
      );

      debugPrint('📥 [SignUpController] Signup API response received. Success: ${response.success}');

      if (response.success && response.data != null) {
        final data = response.data!;
        CustomSnackBar.showSuccess(
          context,
          message: data.message.isNotEmpty ? data.message : 'Sign up successful! OTP sent to email.',
        );

        // Navigate to OTP page after successful signup
        if (context.mounted) {
          context.push(AppPath.otpVerification, extra: {'email': email});
        }
      } else {
        CustomSnackBar.showError(
          context,
          message: response.errorMessage ?? 'Sign up failed. Please try again.',
        );
      }
    } catch (e) {
      debugPrint('💥 [SignUpController] Exception caught during signup: $e');
      CustomSnackBar.showError(
        context,
        message: 'Sign up failed: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
      debugPrint('⏹️ [SignUpController] signUpWithEmail process completed');
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