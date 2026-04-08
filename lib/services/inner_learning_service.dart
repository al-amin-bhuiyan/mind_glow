import '../models/api_response_model.dart';
import '../models/learning_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

class InnerLearningService {
  InnerLearningService._();
  static final InnerLearningService _instance = InnerLearningService._();
  static InnerLearningService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<List<LearningModel>>> getLearnings({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.learningsEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final List<dynamic> dataList;
        if (response.data!.containsKey('data')) {
           dataList = response.data!['data'] as List<dynamic>;
        } else {
           dataList = []; // Fallback, shouldn't reach here if list returned directly
        }

        final learnings = dataList
            .map((json) => LearningModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return ApiResponse.success(data: learnings, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse learnings response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load learnings.',
      statusCode: response.statusCode,
    );
  }
}
