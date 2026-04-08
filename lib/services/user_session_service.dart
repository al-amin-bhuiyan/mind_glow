import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'token_storage_service.dart';

class UserSessionService {
  UserSessionService._();
  static final UserSessionService _instance = UserSessionService._();
  static UserSessionService get instance => _instance;

  final RxInt id = 0.obs;
  final RxString email = ''.obs;
  final RxBool isSuperuser = false.obs;
  final RxBool isLoaded = false.obs;

  Future<void> loadFromCache() async {
    final storage = TokenStorageService.instance;
    final cachedId = await storage.getUserId();
    final cachedEmail = await storage.getUserEmail();

    if (cachedId != null) id.value = cachedId;
    if (cachedEmail != null && cachedEmail.isNotEmpty) email.value = cachedEmail;
    debugPrint('📦 UserSession: loaded from cache — ${email.value}');
  }

  void clear() {
    id.value = 0;
    email.value = '';
    isSuperuser.value = false;
    isLoaded.value = false;
    debugPrint('🔓 UserSession: cleared');
  }
}
