class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://api.mindglow.tech/v1';
  static const String loginEndpoint = '/users/auth/login/'; 
  static const String signupEndpoint = '/users/signup/';
  static const String verifyOtpSignupEndpoint = '/users/signup/verify-otp/';
  static const String resendOtpEndpoint = '/users/signup/resend-otp/';
  static const String completeProfileEndpoint = '/users/signup/complete-profile/';
  static const String contactSupportEndpoint = '/admin/contact-support/';
  static const String passwordResetEndpoint = '/users/auth/password/reset/';
  static const String passwordResetVerifyEndpoint = '/users/auth/password/reset/verify/';
  static const String passwordResetConfirmEndpoint = '/users/auth/password/reset/confirm/';
  static const String changePasswordEndpoint = '/users/auth/password/change/';
  static const String userSummaryEndpoint = '/users/auth/user/summary/';
  static const String quoteEndpoint = '/inspirations/quote/';
  static const String userProfileEndpoint = '/users/auth/user/';
  static const String learningsEndpoint ='/learnings/';
  static const String pastReflectionsEndpoint = '/reflections-chat/past-reflection/';
  static const String newConversationEndpoint = '/reflections-chat/chat/conversations/new/';
  static const String retrieveConversationEndpoint = '/reflections-chat/chat/conversations/';
  static const String lastConversationEndpoint = '/reflections-chat/chat/last/';
  static const String newChatMessageEndpoint = '/reflections-chat/chat/';
  static const String verifyOtp = '/users/signup/verify/';
  static const String resendOtp = '/users/signup/resend-otp/';
  static const String login = '/users/login/';
  static const String deleteProfile = '/users/profile/delete/';
  static const String getInspirationVideos = '/inspirations/videos/';
  static const String favoriteQuoteEndpoint = '/qoute/favorites/';
  static const String topicsEndpoint = '/reflections-chat/topics/';

  // ─── Timeouts ────────────────────────────────────────────────────────────────
  static const int connectTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
}