class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://api.mindglow.tech/v1';
  static const String loginEndpoint = '/users/auth/login/'; 
  static const String signupEndpoint = '/users/signup/';
  static const String verifyOtpSignupEndpoint = '/users/signup/verify-otp/';
  static const String resendOtpEndpoint = '/users/signup/resend-otp/';
  static const String completeProfileEndpoint = '/users/signup/complete-profile/';
  static const String contactSupportEndpoint = '/admin/contact-support/';
  static const String changePasswordEndpoint = '/users/auth/password/change/';
  static const String userSummaryEndpoint = '/users/auth/user/summary/';
  static const String quoteEndpoint = '/inspirations/quote/';
  static const String learningsEndpoint = '/learnings/';

  static const int connectTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
}