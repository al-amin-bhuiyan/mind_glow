import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Controller for Reflect Voice Screen
class ReflectVoiceController extends GetxController {
  // Observable states
  final RxBool isListening = true.obs;
  final RxBool isPaused = false.obs;
  final RxBool isMicPressed = false.obs;
  final RxString statusText = 'Listening...'.obs;

  /// Toggle pause/resume
  void togglePause() {
    isPaused.value = !isPaused.value;
    if (isPaused.value) {
      statusText.value = 'Paused';
      isListening.value = false;
    } else {
      statusText.value = 'Listening...';
      isListening.value = true;
    }
  }

  /// Toggle mic button press
  void toggleMic() {
    isMicPressed.value = !isMicPressed.value;
    if (isMicPressed.value) {
      isListening.value = true;
      statusText.value = 'Recording...';
    } else {
      isListening.value = false;
      statusText.value = 'Tap mic to start';
    }
  }

  /// Stop recording and close
  void stopRecording(BuildContext context) {
    isListening.value = false;
    statusText.value = 'Stopped';
    // TODO: Add logic to save or process the recording
    context.pop();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize recording
    _startListening();
  }

  void _startListening() {
    isListening.value = true;
    statusText.value = 'Listening...';
    // TODO: Add actual voice recording logic
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
