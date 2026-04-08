import '../models/api_response_model.dart';
import '../models/quote_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

class InspirationService {
  InspirationService._();
  static final InspirationService _instance = InspirationService._();
  static InspirationService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<QuoteResponseModel>> getDailyQuote({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.quoteEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = QuoteResponseModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse quote response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load daily quote.',
      statusCode: response.statusCode,
    );
  }
}
