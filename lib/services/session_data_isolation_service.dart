import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'user_session_service.dart';

class SessionDataIsolationService {
  SessionDataIsolationService._();
  static final SessionDataIsolationService _instance =
      SessionDataIsolationService._();

  static SessionDataIsolationService get instance => _instance;

  void clearUserScopedState() {
    UserSessionService.instance.clear();

    // Clear any user-scoped GetX controllers for mind_glow here if applicable
    
    debugPrint('🧹 Cleared user-scoped runtime state');
  }
}
