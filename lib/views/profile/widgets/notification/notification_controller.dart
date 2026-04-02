import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Notification Controller - Manages notification settings state
class NotificationController extends GetxController {
  // Observable states for each notification setting
  final RxBool receiveNewScenarios = true.obs;
  final RxBool practiceReminder = true.obs;
  final RxBool securityAlerts = false.obs;
  final RxBool pushNotifications = true.obs;
  final RxBool emailNotifications = false.obs;

  /// Toggle receive new scenarios notification
  void toggleNewScenarios(bool value) {
    receiveNewScenarios.value = value;
    // TODO: Save to local storage or API
  }

  /// Toggle practice reminder notification
  void togglePracticeReminder(bool value) {
    practiceReminder.value = value;
    // TODO: Save to local storage or API
  }

  /// Toggle security alerts notification
  void toggleSecurityAlerts(bool value) {
    securityAlerts.value = value;
    // TODO: Save to local storage or API
  }

  /// Toggle push notifications
  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
    // TODO: Save to local storage or API
  }

  /// Toggle email notifications
  void toggleEmailNotifications(bool value) {
    emailNotifications.value = value;
    // TODO: Save to local storage or API
  }

  /// Navigate back
  void goBack(BuildContext context) {
    context.pop();
  }
}
