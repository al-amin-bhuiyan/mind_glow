import '../models/api_response_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';
import '../controllers/journey_controller/journey_controller.dart';

class JourneyService {
  JourneyService._();
  static final JourneyService _instance = JourneyService._();
  static JourneyService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<List<ReflectionItem>>> getPastReflections({String? token}) async {
    final response = await _apiService.get(
      endpoint: AppConstants.pastReflectionsEndpoint,
      token: token,
    );

    if (response.success && response.data != null) {
      try {
        final List<dynamic> dataList;
        if (response.data!.containsKey('results')) {
          dataList = response.data!['results'] as List<dynamic>;
        } else if (response.data!.containsKey('data')) {
           dataList = response.data!['data'] as List<dynamic>;
        } else {
           dataList = []; 
        }

        final items = dataList
            .map((json) => ReflectionItem.fromJson(json as Map<String, dynamic>))
            .toList();

        return ApiResponse.success(data: items, statusCode: response.statusCode);
      } catch (e) {
        return ApiResponse.error(
          message: 'Failed to parse past reflections.',
          statusCode: response.statusCode,
        );
      }
    }

    return ApiResponse.error(
      message: response.errorMessage ?? 'Failed to load past reflections.',
      statusCode: response.statusCode,
    );
  }
}
