import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_path.dart';

/// Support and Help Controller - Manages support and help navigation
class SupportAndHelpController extends GetxController {
  /// Handle FAQs tap
  void onFAQsTap(BuildContext context) {
    context.push(AppPath.faqs);
  }

  /// Handle Contact Support tap
  void onContactSupportTap(BuildContext context) {
    context.push(AppPath.contactSupport);
  }

  /// Handle Privacy Policy tap
  void onPrivacyPolicyTap(BuildContext context) {
    context.push(AppPath.privacyPolicy);
  }

  /// Handle Terms & Conditions tap
  void onTermsAndConditionsTap(BuildContext context) {
    context.push(AppPath.termsCondition);
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}
