import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../models/terms_condition_model.dart';

/// Terms & Conditions Controller - Manages terms content and state
class TermsConditionController extends GetxController {
  /// List of terms sections
  final RxList<TermsConditionSection> sections = <TermsConditionSection>[].obs;

  /// Last updated date
  final RxString lastUpdated = 'January 29, 2026'.obs;

  /// Contact email
  final String contactEmail = 'support@mindglow.app';

  @override
  void onInit() {
    super.onInit();
    _initializeTermsContent();
  }

  /// Initialize terms & conditions content
  void _initializeTermsContent() {
    sections.value = [
      // Introduction
      const TermsConditionSection(
        number: '',
        title: 'Introduction',
        content:
        'By using MindGlow, you agree to the following Terms & Conditions. Please read them carefully before using the app.',
        type: TermsSectionType.paragraph,
      ),

      // Section 1: Acceptance of Terms
      const TermsConditionSection(
        number: '1.',
        title: 'Acceptance of Terms',
        content:
        'By creating an account or using MindGlow, you agree to comply with these Terms & Conditions and our Privacy Policy. If you do not agree, please discontinue use of the app.',
        type: TermsSectionType.paragraph,
      ),

      // Section 2: Use of the App
      TermsConditionSection(
        number: '2.',
        title: 'Use of the App',
        content: 'You agree to:',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'Use MindGlow for personal, non commercial purposes only',
          'Provide accurate and up-to-date information when creating your account',
          'Use the app respectfully and as intended',
        ],
        additionalContent: 'You must be at least 13 years old to use MindGlow.',
      ),

      // Section 3: Subscription & Payments
      TermsConditionSection(
        number: '3.',
        title: 'Subscription & Payments',
        content: '',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'MindGlow may offer free access and paid subscription plans',
          'Payments are processed through the Apple App Store and Google Play Store',
          'Subscriptions renew automatically unless canceled at least 24 hours before the renewal date',
          'Refunds are subject to Apple and Google\'s respective policies',
        ],
      ),

      // Section 4: Reflective Conversations & Content
      TermsConditionSection(
        number: '4.',
        title: 'Reflective Conversations & Content',
        content: '',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'MindGlow provides guided, reflective conversations intended for self-reflection and awareness',
          'Content is designed to encourage personal exploration, not to provide advice, instructions, or solutions',
          'Conversations are processed in real time to support the experience',
          'Raw audio is not stored',
        ],
        additionalContent:
        'MindGlow does not guarantee specific outcomes or results from use of the app.',
      ),

      // Section 5: User Content
      TermsConditionSection(
        number: '5.',
        title: 'User Content',
        content:
        'Your reflections, summaries, and inputs belong to you.\nBy using MindGlow, you grant permission to process this content solely to support and improve your experience within the app.\nYou may not upload or create content that is:',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'Harmful or abusive',
          'Illegal',
          'Misleading or deceptive',
          'Intended to harass or threaten others',
        ],
      ),

      // Section 6: Prohibited Activities
      TermsConditionSection(
        number: '6.',
        title: 'Prohibited Activities',
        content: 'You agree not to:',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'Access or attempt to access restricted areas of the app',
          'Reverse engineer, copy, or misuse any part of the service',
          'Use the app for harmful, malicious, or unlawful purposes',
          'Share or transfer your account to another person',
        ],
      ),

      // Section 7: Account Termination
      TermsConditionSection(
        number: '7.',
        title: 'Account Termination',
        content: 'We reserve the right to suspend or terminate accounts that:',
        type: TermsSectionType.bulletList,
        bulletPoints: [
          'Violate these Terms & Conditions',
          'Compromise the safety or integrity of the platform',
        ],
        additionalContent:
        'You may also delete your account at any time through the app settings.',
      ),

      // Section 8: Disclaimer & Limitation of Liability
      TermsConditionSection(
        number: '8.',
        title: 'Disclaimer & Limitation of Liability',
        content: 'MindGlow is a self-reflection tool and is not:',
        type: TermsSectionType.mixed,
        bulletPoints: [
          'Therapy',
          'Mental health treatment',
          'Professional counseling',
        ],
        additionalContent:
        'MindGlow is not responsible for:\n• Network or connectivity issues\n• Device or operating system limitations\n• Interruptions caused by third-party services\nUse of the app is at your own discretion.',
      ),

      // Section 9: Changes to the Terms
      const TermsConditionSection(
        number: '9.',
        title: 'Changes to the Terms',
        content:
        'We may update these Terms & Conditions from time to time. Any changes will be reflected by an updated "Last Updated" date.',
        type: TermsSectionType.paragraph,
      ),

      // Section 10: Contact Us
      const TermsConditionSection(
        number: '10.',
        title: 'Contact Us',
        content:
        'If you have any questions about these Terms & Conditions, please contact us at:',
        type: TermsSectionType.paragraph,
      ),
    ];
  }

  /// Refresh terms content (for future API integration)
  Future<void> refreshTerms() async {
    // TODO: Implement API call to fetch latest terms
    await Future.delayed(const Duration(seconds: 1));
    _initializeTermsContent();
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}
