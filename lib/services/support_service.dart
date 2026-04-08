import '../models/api_response_model.dart';
import '../models/contact_support_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

/// SupportService - Handles support related API calls
class SupportService {
  // Private constructor - singleton pattern
  SupportService._();
  static final SupportService _instance = SupportService._();

  /// Singleton accessor
  static SupportService get instance => _instance;

  // Dependency: composed with ApiService
  final ApiService _apiService = ApiService.instance;

  /// Submits a contact support ticket
  /// POST /admin/contact-support/
  Future<ApiResponse<ContactSupportResponseModel>> submitSupportRequest({
    required ContactSupportRequestModel request,
    String? token, // optional Bearer token if required
  }) async {
    final response = await _apiService.post(
      endpoint: AppConstants.contactSupportEndpoint,
      body: request.toJson(),
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = ContactSupportResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse support response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Submission failed. Please try again.',
      statusCode: response.statusCode,
    );
  }
}
