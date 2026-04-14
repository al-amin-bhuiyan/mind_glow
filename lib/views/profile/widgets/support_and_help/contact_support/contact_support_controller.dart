import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../../../../models/contact_support_model.dart';
import '../../../../../../services/support_service.dart';
import '../../../../../../services/token_storage_service.dart';

/// Contact Support Controller - Manages contact support form state and validation
class ContactSupportController extends GetxController {
  // ─── Dependencies ────────────────────────────────────────────────────────
  final SupportService _supportService = SupportService.instance;
  
  // ─── Text editing controllers for form fields ────────────────────────────
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  /// Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserEmail();
  }

  @override
  void onClose() {
    subjectController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  /// Automatically fill email if the user is authenticated
  Future<void> _loadUserEmail() async {
    final cachedEmail = await TokenStorageService.instance.getUserEmail();
    if (cachedEmail != null && cachedEmail.isNotEmpty) {
      emailController.text = cachedEmail;
    }
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate subject field
  String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a subject';
    }
    if (value.trim().length < 3) {
      return 'Subject must be at least 3 characters';
    }
    return null;
  }

  /// Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!_isValidEmail(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate message field
  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a message';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  /// Submit support request
  Future<void> submitSupportRequest() async {
    // Validate form
    if (!(formKey.currentState?.validate() ?? false)) return;
    
    isLoading.value = true;

    try {
      // Package request model
      final request = ContactSupportRequestModel(
        subject: subjectController.text.trim(),
        email: emailController.text.trim(),
        message: messageController.text.trim(),
      );

      // Attempt to load token if endpoint requires Bearer Token authorization
      final token = await TokenStorageService.instance.getAccessToken();

      final response = await _supportService.submitSupportRequest(
        request: request,
        token: token,
      );

      if (response.success && response.data != null) {
        // Show success message
        Fluttertoast.showToast(
          msg: 'Your message has been sent successfully. We\'ll respond as soon as we can.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          textColor: Colors.white,
        );

        // Clear form
        clearForm();

        // Navigate back after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        if (Get.context != null && Get.context!.mounted) {
           Get.context!.pop();
        }
      } else {
        _showError(response.errorMessage ?? 'Failed to send message. Please try again.');
      }
    } catch (e) {
      debugPrint('❌ Submit support request error: $e');
      _showError('Failed to send message. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String error) {
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: const Color(0xFFE53935),
      textColor: Colors.white,
    );
  }

  /// Clear form fields
  void clearForm() {
    subjectController.clear();
    messageController.clear();
    // Do not clear the email if they were pre-filled via session logic
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}