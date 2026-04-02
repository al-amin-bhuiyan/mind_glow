import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../models/privacy_policy_model.dart';

/// Privacy Policy Controller - Manages privacy policy content and state
class PrivacyPolicyController extends GetxController {
  /// List of privacy policy sections
  final RxList<PrivacyPolicySection> sections = <PrivacyPolicySection>[].obs;

  /// Last updated date
  final RxString lastUpdated = 'January 29, 2026'.obs;

  /// Contact email
  final String contactEmail = 'support@mindglow.app';

  @override
  void onInit() {
    super.onInit();
    _initializePolicyContent();
  }

  /// Initialize privacy policy content
  void _initializePolicyContent() {
    sections.value = [
      // Introduction
      const PrivacyPolicySection(
        number: '',
        title: 'Introduction',
        content:
        'MindGlow is committed to protecting your privacy. This policy explains what information we collect, how it is used, and the choices available to you.',
        type: SectionType.paragraph,
      ),

      // Section 1: Information We Collect
      PrivacyPolicySection(
        number: '1.',
        title: 'Information We Collect',
        content:
        'We collect certain information to provide a safe, personalized, and reliable experience:',
        type: SectionType.bulletList,
        bulletPoints: [
          const BulletPoint(
            label: 'Account Information:',
            description:
            'Email address, login credentials, and subscription details.',
          ),
          const BulletPoint(
            label: 'Usage Information:',
            description:
            'App interactions, selected focus areas, and non-identifiable reflection summaries.',
          ),
          const BulletPoint(
            label: 'Voice Processing Information:',
            description:
            'Spoken input is processed in real time to support interactive responses. Raw audio is not stored.',
          ),
          const BulletPoint(
            label: 'Device Information:',
            description: 'Device type, operating system, and app version.',
          ),
        ],
      ),

      // Section 2: How We Use Your Information
      PrivacyPolicySection(
        number: '2.',
        title: 'How We Use Your Information',
        content: 'Your information is used to:',
        type: SectionType.bulletList,
        bulletPoints: [
          const BulletPoint(
            label: '',
            description: 'Enable interactive reflection sessions',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Personalize your experience',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Improve app performance and reliability',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Manage subscriptions and payments',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Provide customer support',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Maintain security and system integrity',
            isBold: false,
          ),
        ],
      ),

      // Section 3: Voice & Conversation Data
      PrivacyPolicySection(
        number: '3.',
        title: 'Voice & Conversation Data',
        content: '',
        type: SectionType.bulletList,
        bulletPoints: [
          const BulletPoint(
            label: '',
            description:
            'Conversations are processed to generate reflective responses.',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Raw audio is never stored.',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description:
            'Text-based summaries may be saved to your history for personal reference.',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Data is not used to personally identify you.',
            isBold: false,
          ),
        ],
      ),

      // Section 4: Third-Party Services
      PrivacyPolicySection(
        number: '4.',
        title: 'Third-Party Services',
        content: 'We may use trusted third-party providers for:',
        type: SectionType.bulletList,
        bulletPoints: [
          const BulletPoint(
            label: '',
            description: 'Speech recognition',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Voice output',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Subscription payments (Apple & Google)',
            isBold: false,
          ),
        ],
      ),

      // Additional text for section 4
      const PrivacyPolicySection(
        number: '',
        title: '',
        content: 'These providers operate under their own privacy policies.',
        type: SectionType.paragraph,
      ),

      // Section 5: Your Controls & Choices
      PrivacyPolicySection(
        number: '5.',
        title: 'Your Controls & Choices',
        content: 'You may:',
        type: SectionType.bulletList,
        bulletPoints: [
          const BulletPoint(
            label: '',
            description: 'Update your email or password',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Delete your account',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Request removal of stored summaries',
            isBold: false,
          ),
          const BulletPoint(
            label: '',
            description: 'Manage or cancel your subscription at any time',
            isBold: false,
          ),
        ],
      ),

      // Section 6: Data Security
      const PrivacyPolicySection(
        number: '6.',
        title: 'Data Security',
        content:
        'We take reasonable measures to protect your information. However, no method of data transmission or storage can be guaranteed to be completely secure.',
        type: SectionType.paragraph,
      ),

      // Section 7: Children's Privacy
      const PrivacyPolicySection(
        number: '7.',
        title: 'Children\'s Privacy',
        content:
        'MindGlow is not intended for children under the age of 13. We do not knowingly collect information from anyone under this age.',
        type: SectionType.paragraph,
      ),

      // Section 8: Changes to This Policy
      const PrivacyPolicySection(
        number: '8.',
        title: 'Changes to This Policy',
        content:
        'This Privacy Policy may be updated from time to time. Any changes will be reflected by an updated "Last Updated" date.',
        type: SectionType.paragraph,
      ),

      // Section 9: Contact Us
      const PrivacyPolicySection(
        number: '9.',
        title: 'Contact Us',
        content:
        'If you have any questions or concerns regarding this Privacy Policy, please contact us at:',
        type: SectionType.paragraph,
      ),
    ];
  }

  /// Refresh policy content (for future API integration)
  Future<void> refreshPolicy() async {
    // TODO: Implement API call to fetch latest policy
    await Future.delayed(const Duration(seconds: 1));
    _initializePolicyContent();
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context. pop();
  }
}
