import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/services.dart';
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

  // Focus node for text input
  final FocusNode inputFocusNode = FocusNode();

  // Loading state
  final RxBool isLoading = false.obs;

  // Animation controller for see more toggle
  late AnimationController seeMoreAnimationController;

  // Observable for recording state
  final RxBool isRecording = false.obs;

  late stt.SpeechToText _speech;
  bool _isSpeechInitialized = false;

  @override
  void onInit() {
    super.onInit();

    _speech = stt.SpeechToText();
    _initSpeech();

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

    loadPastLearnings();

    // Listen to text controller changes
    textController.addListener(() {
      learningInput.value = textController.text;
    });
  }

  /// Load past learnings from database/API
  Future<void> loadPastLearnings() async {
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
    inputFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
        loadPastLearnings();
      }
    } else if (response != null) {
      // Handle error: possibly show a toast
      debugPrint('Error: \${response.errorMessage}');
    }
  }

  /// Handle suggestion tap
  void onSuggestionTap(String suggestion, BuildContext context) {
    inputFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _generateAndNavigateToLearning(suggestion, context);
  }

  /// Send learning query
  void sendLearningQuery(BuildContext context) {
    final topic = textController.text.trim();
    debugPrint('🔘 Send button tapped. Topic: "$topic"');
    
    inputFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    
    if (topic.isEmpty) {
      debugPrint('⚠️ Topic is empty, aborting.');
      return;
    }

    learningInput.value = '';
    textController.clear(); // Clear the text after sending
    
    debugPrint('🚀 Triggering API call with topic: "$topic"');
    _generateAndNavigateToLearning(topic, context);
  }

  /// Open learning detail
  Future<void> openLearningDetail(LearningModel learning, BuildContext context) async {
    inputFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // Pass the learning object explicitly as extra when navigating with GoRouter
    await context.pushNamed('relationshipLearning', extra: learning);
    loadPastLearnings();
  }

  Future<void> _initSpeech() async {
    try {
      _isSpeechInitialized = await _speech.initialize(
        onError: (error) => debugPrint('Speech to text error: $error'),
        onStatus: (status) {
          debugPrint('Speech to text status: $status');
          if (status == 'done' || status == 'notListening') {
            isRecording.value = false;
          }
        },
      );
    } catch (e) {
      debugPrint('Error initializing speech: $e');
    }
  }

  /// Toggle recording state
  void toggleRecording(BuildContext context) {
    if (!_isSpeechInitialized) {
      _initSpeech().then((_) {
        if (_isSpeechInitialized) {
          _toggleListening(context);
        } else {
          debugPrint("Speech not initialized");
        }
      });
    } else {
      _toggleListening(context);
    }
  }

  void _toggleListening(BuildContext context) {
    if (isRecording.value) {
      isRecording.value = false;
      _speech.stop();
      if (textController.text.trim().isNotEmpty) {
        inputFocusNode.unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        sendLearningQuery(context);
      }
    } else {
      isRecording.value = true;
      final previousText = textController.text;
      _speech.listen(
        onResult: (result) {
          final newText = previousText.isEmpty
              ? result.recognizedWords
              : '$previousText ${result.recognizedWords}';
          
          textController.text = newText;
          learningInput.value = newText;
          
          // Keep cursor at the end to ensure TextField scrolls/updates properly
          textController.selection = TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          );
        },
      );
    }
  }

  @override
  void onClose() {
    seeMoreAnimationController.dispose();
    textController.dispose();
    inputFocusNode.dispose();
    super.onClose();
  }
}