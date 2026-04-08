import 'package:flutter/foundation.dart';
import '../models/api_response_model.dart';
import 'auth_service.dart';
import 'token_storage_service.dart';

enum AuthState {
  firstLaunch,
  unauthenticated,
  authenticated,
}

class AuthStateService {
  AuthStateService._();
  static final AuthStateService _instance = AuthStateService._();
  static AuthStateService get instance => _instance;

  final TokenStorageService _tokenStorage = TokenStorageService.instance;
  final AuthService _authService = AuthService.instance;

  AuthState? _cachedState;

  bool get isResolved => _cachedState != null;
  AuthState? get state => _cachedState;

  Future<AuthState> resolve() async {
    if (_cachedState != null) return _cachedState!;

    _cachedState = await _determineAuthState();
    debugPrint('🔐 AuthState resolved: $_cachedState');
    return _cachedState!;
  }

  void reset() {
    _cachedState = null;
    debugPrint('🔄 AuthState cache cleared');
  }

  void setAuthenticated() {
    _cachedState = AuthState.authenticated;
  }

  void setUnauthenticated() {
    _cachedState = AuthState.unauthenticated;
  }

  Future<AuthState> _determineAuthState() async {
    try {
      final bool seenOnboarding = await _tokenStorage.hasSeenOnboarding();
      if (!seenOnboarding) {
        debugPrint('🆕 No onboarding seen → firstLaunch');
        return AuthState.firstLaunch;
      }

      final String? accessToken = await _tokenStorage.getAccessToken();
      final String? refreshToken = await _tokenStorage.getRefreshToken();

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('🔓 No token stored → unauthenticated');
        return AuthState.unauthenticated;
      }

      // If you have a verify token endpoint, use it here, otherwise assume valid unless HTTP requests fail
      // For now we'll just check if the token exists to speed up boot.
      // If requests start failing with 401 later, you log them out or refresh there.
      debugPrint('✅ Token found → authenticated');
      return AuthState.authenticated;
      
    } catch (e) {
      debugPrint('❌ AuthState error: $e → unauthenticated');
      return AuthState.unauthenticated;
    }
  }
}
