import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RelationshipLearningController extends GetxController {
  // Observable for loading state
  final RxBool isLoading = false.obs;

  // Observable for scroll position
  final RxDouble scrollOffset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadContent();
  }

  /// Load relationship learning content
  void _loadContent() {
    isLoading.value = true;
    // Simulate loading content
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  /// Update scroll offset
  void updateScrollOffset(double offset) {
    scrollOffset.value = offset;
  }

  /// Navigate back to inner learning
  void goBack(BuildContext context) {
    context.pop();
  }
}
