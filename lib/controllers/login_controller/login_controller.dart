import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart'; // Added for debugPrint
import '../../routes/app_path.dart';

import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';
import '../../services/user_session_service.dart';
import '../../services/session_data_isolation_service.dart';

/// Login Controller - Manages login screen state and logic
class LoginController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController emailController = TextEditingController(
    text: 'admin@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'admin123',
  );

  // Observable states
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool rememberMe = false.obs;

  // Services
  final AuthService _authService = AuthService.instance;
  final TokenStorageService _tokenStorage = TokenStorageService.instance;

  // Email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void onInit() {
    super.onInit();
    debugPrint('📝 LoginController initialized');
    // Listen to email changes for real-time validation
    emailController.addListener(_validateEmail);
  }

  @override
  void onClose() {
    debugPrint('🗑️ LoginController disposed');
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    debugPrint('👁️ Password visibility toggled: ${isPasswordVisible.value}');
  }

  /// Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
    debugPrint('📌 Remember me toggled: ${rememberMe.value}');
  }

  /// Navigate to Forgot Password screen
  void navigateToForgotPassword(BuildContext context) {
    debugPrint('🔄 Navigating to Forgot Password');
    context.push(AppPath.resetPassword);
  }

  /// Validate email in real-time
  void _validateEmail() {
    isEmailValid.value = _emailRegex.hasMatch(emailController.text);
  }

  /// Validate form
  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    debugPrint('✅ Form validation status: $isValid');
    return isValid;
  }

  /// Email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      debugPrint('❌ Validation failed: Email is empty');
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value)) {
      debugPrint('❌ Validation failed: Invalid email format');
      return 'Enter a valid email';
    }
    return null;
  }

  /// Password validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      debugPrint('❌ Validation failed: Password is empty');
      return 'Password is required';
    }
    if (value.length < 6) {
      debugPrint('❌ Validation failed: Password too short');
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(BuildContext context) async {
    debugPrint('🚀 Starting signInWithEmail process');
    if (!validateForm()) {
      debugPrint('⛔ Form validation failed, aborting login');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('⏳ Loading state set to true');

      final String email = emailController.text.trim();
      debugPrint('📧 Attempting login with email: $email');

      final response = await _authService.login(
        email: email,
        password: passwordController.text,
      );

      debugPrint(
        '📥 Login API response received. Success: ${response.success}',
      );

      if (response.success && response.data != null) {
        final data = response.data!;
        debugPrint(
          '✅ Login successful. Received token for User ID: ${data.user.id}',
        );

        SessionDataIsolationService.instance.clearUserScopedState();
        debugPrint('🧹 Cleared previous user scoped state');

        await _tokenStorage.saveTokens(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
        );
        debugPrint('💾 Tokens saved locally');

        await _tokenStorage.saveUserInfo(
          id: data.user.id,
          email: data.user.email,
          name: '',
        );
        debugPrint('👤 User info saved locally');

        UserSessionService.instance.id.value = data.user.id;
        UserSessionService.instance.email.value = data.user.email;
        UserSessionService.instance.isSuperuser.value = data.user.isSuperuser;
        UserSessionService.instance.isLoaded.value = true;
        debugPrint('🧠 Global user session updated');

        CustomSnackBar.showSuccess(context, message: 'Login successful!');
        debugPrint('🎉 Success toast displayed');

        if (context.mounted) {
          debugPrint('🔄 Navigating to AppPath.home');
          context.push(AppPath.home);
        }
      } else {
        final errorMsg =
            response.errorMessage ??
            'Login failed. Please check your credentials.';
        debugPrint('❌ Login failed from API: $errorMsg');
        CustomSnackBar.showError(context, message: errorMsg);
      }
    } catch (e) {
      debugPrint('💥 Exception caught during login: $e');
      CustomSnackBar.showError(
        context,
        message: 'Login failed: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
      debugPrint('⏹️ signInWithEmail process completed, loading set to false');
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    debugPrint('🚀 Starting signInWithGoogle process');
    try {
      isLoading.value = true;

      // TODO: Implement Google Sign-in logic
      await Future.delayed(const Duration(seconds: 2));

      CustomSnackBar.showSuccess(
        context,
        message: 'Google sign-in successful!',
      );
      debugPrint('🎉 Google sign-in success toast displayed');
    } catch (e) {
      debugPrint('💥 Exception caught during Google sign-in: $e');
      CustomSnackBar.showError(
        context,
        message: 'Google sign-in failed: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
      debugPrint('⏹️ signInWithGoogle process completed, loading set to false');
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    debugPrint('🚀 Starting signInWithApple process');
    try {
      isLoading.value = true;

      // TODO: Implement Apple Sign-in logic
      await Future.delayed(const Duration(seconds: 2));

      CustomSnackBar.showSuccess(context, message: 'Apple sign-in successful!');
      debugPrint('🎉 Apple sign-in success toast displayed');
    } catch (e) {
      debugPrint('💥 Exception caught during Apple sign-in: $e');
      CustomSnackBar.showError(
        context,
        message: 'Apple sign-in failed: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
      debugPrint('⏹️ signInWithApple process completed, loading set to false');
    }
  }

  /// Navigate to Sign Up screen
  void navigateToSignUp(BuildContext context) {
    debugPrint('🔄 Navigating to Sign Up screen');
    context.push(AppPath.signup);
  }
}
