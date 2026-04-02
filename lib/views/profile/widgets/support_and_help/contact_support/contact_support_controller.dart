import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Contact Support Controller - Manages contact support form state and validation
class ContactSupportController extends GetxController {
  /// Text editing controllers for form fields
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  /// Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Loading state
  final RxBool isLoading = false.obs;

  /// Form validation states
  final RxString subjectError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString messageError = ''.obs;

  @override
  void onClose() {
    subjectController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
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
    // Clear previous errors
    subjectError.value = '';
    emailError.value = '';
    messageError.value = '';

    // Validate form
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // TODO: Implement actual API call
        // final response = await supportRepository.submitSupportRequest(
        //   subject: subjectController.text.trim(),
        //   email: emailController.text.trim(),
        //   message: messageController.text.trim(),
        // );

        // Show success message
        Get.snackbar(
          'Success',
          'Your message has been sent successfully. We\'ll respond as soon as we can.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Clear form
        clearForm();

        // Navigate back after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      } catch (e) {
        // Show error message
        Get.snackbar(
          'Error',
          'Failed to send message. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFE53935),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  /// Clear form fields
  void clearForm() {
    subjectController.clear();
    emailController.clear();
    messageController.clear();
    subjectError.value = '';
    emailError.value = '';
    messageError.value = '';
  }

  /// Navigate back
  void goBack(BuildContext conntext) {
    conntext.pop();
  }
}
