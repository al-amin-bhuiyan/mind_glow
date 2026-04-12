import '../models/api_response_model.dart';
import '../models/learning_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

class InnerLearningService {
  InnerLearningService._();
  static final InnerLearningService _instance = InnerLearningService._();
  static InnerLearningService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<LearningModel>> generateLearningInfo({required String topic, String? token}) async {
    final response = await _apiService.post(
      endpoint: AppConstants.learningsEndpoint,
      body: {'topic': topic},
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final model = LearningModel.fromJson(response.data!);
        return ApiResponse.success(data: model, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse generated learning response.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to generate learning.',
      statusCode: response.statusCode,
    );
  }

  Future<ApiResponse<List<LearningModel>>> getLearnings({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.learningsEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        List<dynamic> dataList = [];
        
        if (response.data!.containsKey('results')) {
          dataList = response.data!['results'] as List<dynamic>;
        } else if (response.data!.containsKey('data')) {
           dataList = response.data!['data'] as List<dynamic>;
        } else {
           // Maybe it's a direct list wrapped implicitly, or empty
           dataList = []; 
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