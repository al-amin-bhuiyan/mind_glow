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

  Future<ApiResponse<List<dynamic>>> getInspirationVideos({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.getInspirationVideos,
      token: token,
    );

    if (response.success && response.data != null) {
      final dynamic data = response.data;
      if (data is List) {
        return ApiResponse.success(data: data, statusCode: response.statusCode);
      } else if (data is Map && data['data'] is List) {
        return ApiResponse.success(data: data['data'] as List<dynamic>, statusCode: response.statusCode);
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load videos.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<List<dynamic>>> getFavoriteQuotes({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.favoriteQuoteEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      final dynamic data = response.data;
      if (data is List) {
        return ApiResponse.success(data: data, statusCode: response.statusCode);
      } else if (data is Map && data['data'] is List) {
        return ApiResponse.success(data: data['data'] as List<dynamic>, statusCode: response.statusCode);
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load favorite quotes.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> favoriteQuote({
    required String quote,
    required String author,
    String? token,
  }) async {
    final response = await _apiService.post(
      endpoint: AppConstants.favoriteQuoteEndpoint,
      body: {
        'quote': quote,
        'author': author,
      },
      token: token,
    );

    if (response.success && response.data != null) {
      return ApiResponse.success(data: response.data!, statusCode: response.statusCode);
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to favorite quote.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> removeFavoriteQuote({
    required String id,
    String? token,
  }) async {
    final response = await _apiService.delete(
      endpoint: '${AppConstants.favoriteQuoteEndpoint}$id/',
      token: token,
    );

    if (response.success) {
      return ApiResponse.success(data: response.data ?? {}, statusCode: response.statusCode);
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to remove favorite quote.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<List<String>>> getTopics({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.topicsEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      final dynamic data = response.data;
      if (data is List) {
        return ApiResponse.success(
          data: data.map((e) => e.toString()).toList(), 
          statusCode: response.statusCode
        );
      } else if (data is Map && data['data'] is List) {
        return ApiResponse.success(
          data: (data['data'] as List).map((e) => e.toString()).toList(),
          statusCode: response.statusCode
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load topics.',
      statusCode: response.statusCode,
    );
  }
}