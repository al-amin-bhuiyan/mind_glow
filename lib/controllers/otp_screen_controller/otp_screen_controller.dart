import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:toastification/toastification.dart';

import '../../routes/app_path.dart';
import '../../services/auth_service.dart';
import '../../services/auth_state_service.dart';
import '../../services/token_storage_service.dart';
import '../../widgets/custom_snackbar.dart';

/// OTP Screen Controller - Manages OTP verification screen state and logic
class OtpScreenController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers for each OTP digit
  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  final TextEditingController otp5Controller = TextEditingController();
  final TextEditingController otp6Controller = TextEditingController();

  // Focus nodes for each OTP field
  final FocusNode otp1FocusNode = FocusNode();
  final FocusNode otp2FocusNode = FocusNode();
  final FocusNode otp3FocusNode = FocusNode();
  final FocusNode otp4FocusNode = FocusNode();
  final FocusNode otp5FocusNode = FocusNode();
  final FocusNode otp6FocusNode = FocusNode();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxString userEmail = ''.obs;

  // Observable states for each OTP field to track input
  final RxString otp1 = ''.obs;
  final RxString otp2 = ''.obs;
  final RxString otp3 = ''.obs;
  final RxString otp4 = ''.obs;
  final RxString otp5 = ''.obs;
  final RxString otp6 = ''.obs;

  // Timer states
  final RxInt _remainingSeconds = 60.obs;
  final RxBool canResend = true.obs;
  Timer? _timer;

  // Dependencies
  final AuthService _authService = AuthService.instance;
  final TokenStorageService _tokenStorage = TokenStorageService.instance;

  @override
  void onInit() {
    super.onInit();
    // Listen to controller changes to update observable states
    otp1Controller.addListener(() => otp1.value = otp1Controller.text);
    otp2Controller.addListener(() => otp2.value = otp2Controller.text);
    otp3Controller.addListener(() => otp3.value = otp3Controller.text);
    otp4Controller.addListener(() => otp4.value = otp4Controller.text);
    otp5Controller.addListener(() => otp5.value = otp5Controller.text);
    otp6Controller.addListener(() => otp6.value = otp6Controller.text);
  }

  /// Set email from route parameters
  void setEmail(String email) {
    userEmail.value = email;
  }

  /// Get formatted timer text
  String get timerText {
    final minutes = (_remainingSeconds.value ~/ 60).toString().padLeft(1, '0');
    final seconds = (_remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _stopTimer();
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();

    otp1FocusNode.dispose();
    otp2FocusNode.dispose();
    otp3FocusNode.dispose();
    otp4FocusNode.dispose();
    otp5FocusNode.dispose();
    otp6FocusNode.dispose();

    super.onClose();
  }

  /// Get the complete OTP code
  String getOtpCode() {
    return otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text +
        otp6Controller.text;
  }

  /// Verify OTP code
  Future<void> verifyCode(BuildContext context) async {
    final otpCode = getOtpCode();

    if (otpCode.length != 6) {
      CustomSnackBar.showError(context, message: 'Please enter the complete 6-digit code');
      return;
    }

    if (userEmail.value.isEmpty) {
      CustomSnackBar.showError(context, message: 'Email not found. Please go back and try again.');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔐 Verifying OTP for: ${userEmail.value}');

      final response = await _authService.verifyOtpSignup(
        email: userEmail.value,
        code: otpCode,
      );

      if (response.success && response.data != null) {
        final data = response.data!;
        debugPrint('✅ ${data.message}');

        // Save JWT tokens
        await _tokenStorage.saveTokens(
          accessToken: data.access,
          refreshToken: data.refresh,
        );

        // Mark auth state as authenticated
        AuthStateService.instance.setAuthenticated();

        CustomSnackBar.showSuccess(
          context,
          message: data.message.isNotEmpty ? data.message : 'Email verified successfully! Welcome aboard 🎉',
        );

        // Small delay so toast is visible
        await Future.delayed(const Duration(milliseconds: 700));

        // Navigate to home page
        if (context.mounted) {
          context.pushReplacement(AppPath.innerConnection);
        }
      } else {
        CustomSnackBar.showError(
          context,
          message: response.errorMessage ?? 'Invalid verification code. Please try again.',
        );
      }
    } catch (e) {
      debugPrint('❌ OTP verify error: $e');
      CustomSnackBar.showError(context, message: 'Verification failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Starts the 60-second resend countdown timer
  void _startTimer() {
    _remainingSeconds.value = 60;
    canResend.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds.value > 0) {
        _remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Cancels the countdown timer
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Resend OTP code
  Future<void> resendCode(BuildContext context) async {
    if (!canResend.value) {
      CustomSnackBar.showInfo(
        context,
        message: 'Please wait $timerText before resending',
      );
      return;
    }

    if (userEmail.value.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'Email not found. Please go back and try again.',
      );
      return;
    }

    // Start countdown timer immediately
    _startTimer();
    isLoading.value = true;

    try {
      debugPrint('📨 Resending OTP to: ${userEmail.value}');

      final response = await _authService.resendOtp(
        email: userEmail.value,
      );

      if (response.success && response.data != null) {
        final data = response.data!;
        
        CustomSnackBar.showSuccess(
          context,
          message: data.message.isNotEmpty ? data.message : 'OTP code has been resent to ${userEmail.value}',
        );

        // Clear all OTP fields
        clearOtpFields();
      } else {
        CustomSnackBar.showError(
          context,
          message: response.errorMessage ?? 'Failed to resend code. Please try again.',
        );
        _stopTimer();
        canResend.value = true;
      }
    } catch (e) {
      debugPrint('❌ Resend OTP error: $e');
      CustomSnackBar.showError(
        context,
        message: 'Failed to resend OTP code. Please try again.',
      );
      _stopTimer();
      canResend.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all OTP fields
  void clearOtpFields() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
    otp1FocusNode.requestFocus();
  }

  /// Handle OTP input and auto-focus next field
  void onOtpChanged(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 6) {
      // Move to next field
      switch (index) {
        case 1:
          otp2FocusNode.requestFocus();
          break;
        case 2:
          otp3FocusNode.requestFocus();
          break;
        case 3:
          otp4FocusNode.requestFocus();
          break;
        case 4:
          otp5FocusNode.requestFocus();
          break;
        case 5:
          otp6FocusNode.requestFocus();
          break;
        case 6:
          otp6FocusNode.unfocus();
          break;
      }
    } else if (value.isEmpty && index > 1) {
      // Move to previous field on backspace
      switch (index) {
        case 2:
          otp1FocusNode.requestFocus();
          break;
        case 3:
          otp2FocusNode.requestFocus();
          break;
        case 4:
          otp3FocusNode.requestFocus();
          break;
        case 5:
          otp4FocusNode.requestFocus();
          break;
        case 6:
          otp5FocusNode.requestFocus();
          break;
      }
    }
  }

  /// Handle paste from clipboard manually
  Future<void> handlePasteFromClipboard(BuildContext context) async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData != null && clipboardData.text != null) {
        final pastedText = clipboardData.text!;
        _handlePaste(pastedText, context);
      }
    } catch (e) {
      // Clipboard error
      Get.snackbar(
        'Error',
        'Failed to paste from clipboard',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Handle pasted text from TextField (called when user pastes directly into field)
  void handlePastedText(String pastedText, int fieldIndex, BuildContext context) {
    _handlePaste(pastedText, context);
  }

  /// Handle paste event - distribute digits across all fields
  void _handlePaste(String pastedText, BuildContext context) {
    // Remove any non-digit characters
    final digits = pastedText.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) return;

    // Check if more than 6 digits
    if (digits.length > 6) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        title: const Text('Invalid OTP'),
        description: const Text('OTP should not be more than 6 digits'),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: false,
        dragToClose: true,
      );
      return;
    }

    // Get all controllers in order
    final controllers = [
      otp1Controller,
      otp2Controller,
      otp3Controller,
      otp4Controller,
      otp5Controller,
      otp6Controller,
    ];

    // Clear all fields first
    for (var ctrl in controllers) {
      ctrl.clear();
    }

    // Distribute digits starting from the first field
    final numDigits = digits.length;
    for (int i = 0; i < numDigits; i++) {
      controllers[i].text = digits[i];
    }

    // Focus on the next empty field or unfocus if all filled
    if (numDigits >= 6) {
      otp6FocusNode.unfocus();
    } else {
      final focusNodes = [
        otp1FocusNode,
        otp2FocusNode,
        otp3FocusNode,
        otp4FocusNode,
        otp5FocusNode,
        otp6FocusNode,
      ];
      focusNodes[numDigits].requestFocus();
    }
  }

  /// Navigate back to reset password screen
  void navigateBack(BuildContext context) {
    context.pop();
  }
}