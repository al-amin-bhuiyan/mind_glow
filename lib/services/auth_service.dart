import '../models/api_response_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../models/otp_verify_model.dart';
import '../models/resend_otp_model.dart';
import '../models/complete_profile_model.dart';
import '../models/change_password_model.dart';
import '../models/user_summary_model.dart';
import '../models/user_profile_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

class AuthService {
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequestModel(email: email, password: password);

    final response = await _apiService.post(
      endpoint: AppConstants.loginEndpoint,
      body: request.toJson(),
    );

    if (response.success && response.data != null) {
      try {
        final model = LoginResponseModel.fromJson(response.data!);
        if (model.accessToken.trim().isEmpty || model.refreshToken.trim().isEmpty) {
          final payload = response.data!;
          final message =
              (payload['detail'] ?? payload['message'] ?? payload['error'])
                  ?.toString() ??
              'Login failed. Check email and password.';
          return ApiResponse.error(
            message: message,
            statusCode: response.statusCode,
          );
        }
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse login response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Login failed. Check email and password.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<SignupResponseModel>> signup({
    required String email,
    required String password,
  }) async {
    final request = SignupRequestModel(email: email, password: password);

    final response = await _apiService.post(
      endpoint: AppConstants.signupEndpoint,
      body: request.toJson(),
    );

    if (response.success && response.data != null) {
      try {
        final model = SignupResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse signup response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Signup failed. Please try again.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<OtpVerifyResponseModel>> verifyOtpSignup({
    required String email,
    required String code,
  }) async {
    final request = OtpVerifyRequestModel(email: email, code: code);

    final response = await _apiService.post(
      endpoint: AppConstants.verifyOtpSignupEndpoint,
      body: request.toJson(),
    );

    if (response.success && response.data != null) {
      try {
        final model = OtpVerifyResponseModel.fromJson(response.data!);
        
        // Ensure tokens are actually returned
        if (model.access.trim().isEmpty || model.refresh.trim().isEmpty) {
          final payload = response.data!;
          final message = (payload['message'] ?? payload['detail'] ?? payload['error'])?.toString() ?? 'Verification failed';
          return ApiResponse.error(
            message: message,
            statusCode: response.statusCode,
          );
        }

        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse verification response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Verification failed. Please try again.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<ResendOtpResponseModel>> resendOtp({
    required String email,
  }) async {
    final request = ResendOtpRequestModel(email: email);

    final response = await _apiService.post(
      endpoint: AppConstants.resendOtpEndpoint,
      body: request.toJson(),
    );

    if (response.success && response.data != null) {
      try {
        final model = ResendOtpResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse resend OTP response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to resend OTP. Please try again.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<CompleteProfileResponseModel>> completeProfile({
    required CompleteProfileRequestModel request,
    String? token, // If it requires token
  }) async {
    final response = await _apiService.post(
      endpoint: AppConstants.completeProfileEndpoint,
      body: request.toJson(),
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = CompleteProfileResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse complete profile response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to complete profile. Please try again.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<ChangePasswordResponseModel>> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
    String? token,
  }) async {
    final request = ChangePasswordRequestModel(
      oldPassword: oldPassword,
      newPassword1: newPassword1,
      newPassword2: newPassword2,
    );

    final response = await _apiService.post(
      endpoint: AppConstants.changePasswordEndpoint,
      body: request.toJson(),
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = ChangePasswordResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse change password response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to change password. Please try again.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<UserSummaryResponseModel>> getUserSummary({
    String? token,
  }) async {
    final response = await _apiService.get(
      endpoint: AppConstants.userSummaryEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = UserSummaryResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse user summary response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load user summary.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<UserProfileModel>> getUserProfile({
    String? token,
  }) async {
    final response = await _apiService.get(
      endpoint: AppConstants.userProfileEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = UserProfileModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse user profile response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load user profile.',
      statusCode: response.statusCode,
    );
  }
}