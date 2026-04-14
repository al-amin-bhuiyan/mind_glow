import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'user_session_service.dart';

import '../controllers/home_controller/home_controller.dart';
import '../controllers/profile_controller/profile_controller.dart';
import '../controllers/journey_controller/journey_controller.dart';
import '../controllers/inspire_controller/inspire_controller.dart';
import '../controllers/inner_learning_controller/inner_learning_controller.dart';
import '../controllers/reflect_controller/reflect_controller.dart';

class SessionDataIsolationService {
  SessionDataIsolationService._();
  static final SessionDataIsolationService _instance =
      SessionDataIsolationService._();

  static SessionDataIsolationService get instance => _instance;

  void clearUserScopedState() {
    UserSessionService.instance.clear();

    // Clear any user-scoped GetX controllers for mind_glow here if applicable
    Get.delete<HomeController>();
    Get.delete<ProfileController>();
    Get.delete<JourneyController>();
    Get.delete<InspireController>();
    Get.delete<InnerLearningController>();
    Get.delete<ReflectController>();

    debugPrint('🧹 Cleared user-scoped runtime state');
  }
}