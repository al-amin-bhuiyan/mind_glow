import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reflect Blob Controller - Manages the initial reflect welcome screen state
class ReflectBlobController extends GetxController {
  /// Animation controller for blob
  final RxBool isAnimating = false.obs;

  /// Scale animation value
  final RxDouble blobScale = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startBlobAnimation();
  }

  /// Start blob breathing animation
  void _startBlobAnimation() {
    isAnimating.value = true;
    _animateBlob();
  }

  /// Animate blob with breathing effect
  Future<void> _animateBlob() async {
    while (isAnimating.value) {
      // Scale up
      blobScale.value = 1.1;
      await Future.delayed(const Duration(milliseconds: 1500));

      // Scale down
      blobScale.value = 1.0;
      await Future.delayed(const Duration(milliseconds: 1500));
    }
  }

  /// Stop blob animation
  void stopAnimation() {
    isAnimating.value = false;
    blobScale.value = 1.0;
  }

  /// Navigate back
  void goBack(BuildContext context) {
    // stopAnimation();
    Navigator.of(context).pop();
  }

  /// Start reflection session
  void startReflection(BuildContext context) {
    stopAnimation();
    // TODO: Navigate to main reflect chat screen or show input dialog
    Get.snackbar(
      'Starting Reflection',
      'Opening reflection session...',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }
}
