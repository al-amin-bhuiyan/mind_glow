import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Controller for Subscription Screen - handles subscription logic
class SubscriptionController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString selectedPlan = 'free'.obs; // 'free' or 'inner'

  /// Select Free Plan
  void selectFreePlan() {
    selectedPlan.value = 'free';
  }

  /// Select Inner Plan
  void selectInnerPlan() {
    selectedPlan.value = 'inner';
  }

  /// Continue with selected plan
  void continueWithPlan(BuildContext context) {
    if (selectedPlan.value == 'inner') {
      // TODO: Implement subscription purchase flow
      print('Continue with MindGlow Inner subscription');
      // Navigate to payment or confirmation screen
    } else {
      // Free plan - just go back
      print('Continue with Free plan');
      context.pop();
    }
  }

  /// Handle back button press
  void goBack(BuildContext context) {
    context.pop();
  }

  /// Check if plan is selected
  bool isPlanSelected(String plan) => selectedPlan.value == plan;
}
