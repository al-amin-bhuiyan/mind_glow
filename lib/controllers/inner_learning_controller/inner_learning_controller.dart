import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../models/api_response_model.dart';
import '../../models/learning_model.dart';
import '../../services/inner_learning_service.dart';
import '../../services/token_storage_service.dart';

class InnerLearningController extends GetxController with GetSingleTickerProviderStateMixin {
  // Observable list of past learnings
  final RxList<LearningModel> pastLearnings = <LearningModel>[].obs;

  // Observable for showing all learnings
  final RxBool showAllLearnings = false.obs;

  // Observable for text input
  final RxString learningInput = ''.obs;

  // Text editing controller for input field
  final TextEditingController textController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  // Animation controller for see more toggle
  late AnimationController seeMoreAnimationController;

  @override
  void onInit() {
    super.onInit();

    // Initialize animation controller
    seeMoreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    // Set initial value to match state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (showAllLearnings.value) {
        seeMoreAnimationController.value = 1.0;
      } else {
        seeMoreAnimationController.value = 0.0;
      }
    });

    _loadPastLearnings();

    // Listen to text controller changes
    textController.addListener(() {
      learningInput.value = textController.text;
    });
  }

  /// Load past learnings from database/API
  Future<void> _loadPastLearnings() async {
    isLoading.value = true;
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InnerLearningService.instance.getLearnings(token: token);

      if (response.success && response.data != null) {
        pastLearnings.value = response.data!;
      } else {
        // Fallback mock data if API fails or is empty
        pastLearnings.value = [
          LearningModel(
            id: '1',
            date: 'April 12',
            title: 'learnAboutRelationships',
            description: 'mockDesc1',
          ),
          LearningModel(
            id: '2',
            date: 'April 12',
            title: 'learnAboutSelfReflection',
            description: 'mockDesc2',
          ),
          LearningModel(
            id: '3',
            date: 'April 12',
            title: 'learnAboutSelfConfident',
            description: 'mockDesc3',
          ),
        ];
      }
    } catch (e) {
      debugPrint('Error loading learnings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get learnings to display based on show more state
  List<LearningModel> get displayedLearnings {
    if (showAllLearnings.value) {
      return pastLearnings;
    }
    return pastLearnings.take(3).toList();
  }

  /// Toggle show more/less
  void toggleShowMore() {
    showAllLearnings.value = !showAllLearnings.value;

    // Animate the see more icon
    if (showAllLearnings.value) {
      seeMoreAnimationController.forward(); // Expand animation
    } else {
      seeMoreAnimationController.reverse(); // Collapse animation
    }
  }

  Future<void> _generateAndNavigateToLearning(String topic, BuildContext context) async {
    isLoading.value = true;
    ApiResponse<LearningModel>? response;
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      response = await InnerLearningService.instance.generateLearningInfo(
        topic: topic,
        token: token,
      );
    } catch (e) {
      debugPrint('Error generating learning: $e');
    } finally {
      isLoading.value = false;
    }

    if (response != null && response.success && response.data != null) {
      // Insert the newly generated learning at the top of the list instantly
      pastLearnings.insert(0, response.data!);
      
      // Send newly generated learning data to page
      if (context.mounted) {
        await context.pushNamed('relationshipLearning', extra: response.data);
        // Refresh the list from the GET API instantly when the user comes back
        _loadPastLearnings();
      }
    } else if (response != null) {
      // Handle error: possibly show a toast
      debugPrint('Error: \${response.errorMessage}');
    }
  }

  /// Handle suggestion tap
  void onSuggestionTap(String suggestion, BuildContext context) {
    FocusScope.of(context).unfocus();
    _generateAndNavigateToLearning(suggestion, context);
  }

  /// Send learning query
  void sendLearningQuery(BuildContext context) {
    final topic = textController.text.trim();
    debugPrint('🔘 Send button tapped. Topic: "$topic"');
    
    FocusScope.of(context).unfocus();
    
    if (topic.isEmpty) {
      debugPrint('⚠️ Topic is empty, aborting.');
      return;
    }

    learningInput.value = '';
    textController.clear();
    
    debugPrint('🚀 Triggering API call with topic: "$topic"');
    _generateAndNavigateToLearning(topic, context);
  }

  /// Open learning detail
  Future<void> openLearningDetail(LearningModel learning, BuildContext context) async {
    // Pass the learning object explicitly as extra when navigating with GoRouter
    await context.pushNamed('relationshipLearning', extra: learning);
    _loadPastLearnings();
  }

  @override
  void onClose() {
    seeMoreAnimationController.dispose();
    textController.dispose();
    super.onClose();
  }
}