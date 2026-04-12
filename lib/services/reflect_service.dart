import '../models/api_response_model.dart';
import '../utils/app_constants.dart';
import 'api_service.dart';

class ReflectService {
  ReflectService._();
  static final ReflectService _instance = ReflectService._();
  static ReflectService get instance => _instance;

  final ApiService _apiService = ApiService.instance;

  Future<ApiResponse<Map<String, dynamic>>> startNewConversation({required String token}) async {
    final response = await _apiService.post(
      endpoint: AppConstants.newConversationEndpoint,
      body: {}, // no body
      token: token,
    );
    return response;
  }

  Future<ApiResponse<Map<String, dynamic>>> getConversation({
    required int conversationId,
    required String token,
  }) async {
    final response = await _apiService.get(
      endpoint: '${AppConstants.retrieveConversationEndpoint}$conversationId/messages/',
      token: token,
    );
    return response;
  }

  Future<ApiResponse<Map<String, dynamic>>> sendChatMessage({
    required String message,
    required int conversationId,
    required String token,
  }) async {
    final response = await _apiService.post(
      endpoint: AppConstants.newChatMessageEndpoint,
      body: {
        "message": message,
        "conversation_id": conversationId,
      },
      token: token,
    );
    return response;
  }
}