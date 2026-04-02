import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../models/learning_model.dart';

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
  void _loadPastLearnings() {
    pastLearnings.value = [
      LearningModel(
        id: '1',
        date: 'April 12',
        title: 'Learn About Relationships',
        description:
        'You reflected on moments where speaking up felt uncertain.',
      ),
      LearningModel(
        id: '2',
        date: 'April 12',
        title: 'Learn About Self Reflection.',
        description:
        'You considered how past experiences have shaped your sense of confidence.',
      ),
      LearningModel(
        id: '3',
        date: 'April 12',
        title: 'Learn About Self Confident.',
        description:
        'You shared that sometimes you feel a weight in your sense of confidence.',
      ),
      LearningModel(
        id: '4',
        date: 'April 11',
        title: 'Learn About Patience',
        description:
        'You explored how waiting can sometimes feel uncomfortable.',
      ),
      LearningModel(
        id: '5',
        date: 'April 10',
        title: 'Learn About Growth',
        description:
        'You discovered how small steps lead to meaningful changes.',
      ),
    ];
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

  /// Handle suggestion tap
  void onSuggestionTap(String suggestion, BuildContext context) {
    // For now, all suggestions navigate to relationship learning
    // TODO: Create separate pages for self reflection and self confident
    context.pushNamed('relationshipLearning');
  }

  /// Send learning query
  void sendLearningQuery(BuildContext context) {
    if (learningInput.value.trim().isEmpty) return;

    // For now, all queries navigate to relationship learning
    // TODO: Create separate pages for different learning topics
    context.pushNamed('relationshipLearning');
    learningInput.value = '';
    textController.clear();
  }

  /// Open learning detail
  void openLearningDetail(LearningModel learning, BuildContext context) {
    // For now, all learning cards navigate to relationship learning
    // TODO: Create separate detail pages for each learning type
    context.pushNamed('relationshipLearning');
  }

  @override
  void onClose() {
    seeMoreAnimationController.dispose();
    textController.dispose();
    super.onClose();
  }
}
