import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../models/faq_model.dart';

/// FAQs Controller - Manages FAQ list and expansion states
class FaqsController extends GetxController {
  /// List of FAQ items
  final RxList<FaqModel> faqList = <FaqModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFaqs();
  }

  /// Initialize FAQ list with predefined questions and answers
  void _initializeFaqs() {
    faqList.value = [
      const FaqModel(
        question: 'What is this app for?',
        answer:
        'This app is a private space for self-reflection and self-awareness. It invites you to slow down, look inward, and explore your thoughts and emotions through thoughtful questions. There is no advice or judgment—only space to notice what feels present and reconnect with yourself at your own pace. You can return anytime and continue from wherever you are, without pressure or evaluation.',
        isExpanded: false,
      ),
      const FaqModel(
        question: 'How does the conversation practice work?',
        answer:
        'The experience guides you through open-ended questions that help you reflect on real-life situations and inner experiences. You respond in your own words, at your own pace, without advice or judgment. You can pause anytime and return later to continue from where you left off.',
        isExpanded: false,
      ),
      const FaqModel(
        question: 'Will the conversations be the same every time?',
        answer:
        'No, the conversations are designed to adapt and vary based on different themes and your personal journey. Each session offers unique prompts to help you explore different aspects of yourself.',
        isExpanded: false,
      ),
      const FaqModel(
        question: 'What is the "Create Your Own Scenario" feature?',
        answer:
        'This feature allows you to create custom reflection scenarios tailored to your specific needs or situations. You can design personalized prompts and questions that resonate with your current experiences.',
        isExpanded: false,
      ),
    ];
  }

  /// Toggle expansion state of a specific FAQ item
  void toggleExpansion(int index) {
    if (index >= 0 && index < faqList.length) {
      final updatedFaq = faqList[index].copyWith(
        isExpanded: !faqList[index].isExpanded,
      );
      faqList[index] = updatedFaq;
    }
  }

  /// Collapse all FAQ items
  void collapseAll() {
    faqList.value = faqList.map((faq) {
      return faq.copyWith(isExpanded: false);
    }).toList();
  }

  /// Expand all FAQ items
  void expandAll() {
    faqList.value = faqList.map((faq) {
      return faq.copyWith(isExpanded: true);
    }).toList();
  }

  /// Navigate back
  void goBack(BuildContext context ) {
    context.pop();
  }
}
