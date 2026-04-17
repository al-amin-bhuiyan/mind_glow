import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../journey_controller/journey_controller.dart';

import '../../services/reflect_service.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Controller for Reflect Screen - handles chat messages and interactions
class ReflectController extends GetxController {
  // Observable list of messages
  final messages = <ChatMessage>[].obs;

  // Text editing controller for input field
  final TextEditingController messageController = TextEditingController();

  // Observable for loading state
  final isLoading = false.obs;

  // Observable for recording state
  final isRecording = false.obs;

  // Observable for user profile picture
  final RxString userProfilePicture = ''.obs;

  // Scroll controller for auto-scrolling
  final ScrollController scrollController = ScrollController();

  late stt.SpeechToText _speech;
  bool _isSpeechInitialized = false;

  int? currentConversationId;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    _initSpeech();
    _fetchUserProfile();
    // Initially clear, no need for demo messages now since it's driven by real API
    messages.clear();

    // Listen to changes to scroll to bottom
    ever(messages, (_) => _scrollToBottom());
    ever(isLoading, (_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _fetchUserProfile() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      if (token == null) return;
      final response = await AuthService.instance.getUserProfile(token: token);
      if (response.success && response.data != null && response.data!.profilePicture != null) {
        userProfilePicture.value = response.data!.profilePicture!;
      }
    } catch (e) {
      debugPrint('Error fetching user profile in ReflectController: $e');
    }
  }

  void refreshProfile() {
    _fetchUserProfile();
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

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }

  /// Start a new conversation via API
  Future<bool> startNewConversation() async {
    try {
      isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await ReflectService.instance.startNewConversation(token: token ?? '');

      if (response.success && response.data != null) {
        currentConversationId = response.data!['id'];
        messages.clear(); // Clear old messages
        return true;
      }
    } catch (e) {
      debugPrint('Error starting conversation: $e');
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  /// Load an existing conversation
  Future<bool> loadExistingConversation(int conversationId) async {
    try {
      isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await ReflectService.instance.getConversation(
        conversationId: conversationId,
        token: token ?? '',
      );

      if (response.success && response.data != null) {
        currentConversationId = conversationId;
        messages.clear(); // Clear old messages
        
        // Because ApiService wraps lists in {"data": [...]}, we fetch it from 'data'. Or if the API wrapped it in 'results', we check for 'results' or 'messages'.
        List<dynamic>? messagesList;
        if (response.data!.containsKey('data') && response.data!['data'] is List) {
          messagesList = response.data!['data'] as List<dynamic>?;
        } else if (response.data!.containsKey('results') && response.data!['results'] is List) {
          messagesList = response.data!['results'] as List<dynamic>?;
        } else if (response.data!.containsKey('messages') && response.data!['messages'] is List) {
          messagesList = response.data!['messages'] as List<dynamic>?;
        } else if (response.data! is List) {
          // Fallback if not wrapped (shouldn't happen with current ApiService)
          messagesList = response.data as List<dynamic>?;
        }

        if (messagesList != null) {
          for (var msg in messagesList) {
            messages.add(ChatMessage(
              text: msg['content'] ?? '',
              isUser: msg['sender'] == 'user',
              timestamp: DateTime.tryParse(msg['created_at']?.toString() ?? '')?.toLocal() ?? DateTime.now(),
            ));
          }
        }
        return true;
      }
    } catch (e) {
      debugPrint('Error loading conversation: $e');
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  /// Send a text message via API
  Future<void> sendMessageAsync() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    if (currentConversationId == null) {
      final success = await startNewConversation();
      if (!success || currentConversationId == null) {
        return; // failed to create conversation
      }
    }

    // Add user message locally
    messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    // Clear input field
    messageController.clear();

    try {
      isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await ReflectService.instance.sendChatMessage(
        message: text,
        conversationId: currentConversationId!,
        token: token ?? '',
      );

      if (response.success && response.data != null) {
        final messagesList = response.data!['messages'] as List<dynamic>?;
        if (messagesList != null && messagesList.isNotEmpty) {
          final lastAiMessageData = messagesList.lastWhere(
            (msg) => msg['sender'] == 'ai',
            orElse: () => null,
          );
          
          if (lastAiMessageData != null) {
            messages.add(ChatMessage(
              text: lastAiMessageData['content'],
              isUser: false,
              timestamp: DateTime.tryParse(lastAiMessageData['created_at'].toString())?.toLocal() ?? DateTime.now(),
            ));
          }
        }
      }
    } catch (e) {
      debugPrint('Error sending chat message: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Send a text message (Legacy method adapter)
  void sendMessage() {
    sendMessageAsync();
  }

  /// Toggle voice recording
  void toggleRecording(BuildContext context) {
    if (!_isSpeechInitialized) {
      _initSpeech().then((_) {
        if (_isSpeechInitialized) {
          _toggleListening();
        } else {
          // Show error or request permissions
          debugPrint("Speech not initialized");
        }
      });
    } else {
      _toggleListening();
    }
  }

  void _toggleListening() {
    if (isRecording.value) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  /// Start voice recording
  void _startRecording() {
    isRecording.value = true;
    final previousText = messageController.text;
    _speech.listen(
      onResult: (result) {
        final newText = previousText.isEmpty
            ? result.recognizedWords
            : '$previousText ${result.recognizedWords}';
            
        messageController.text = newText;
        
        // Keep cursor at the end to ensure TextField scrolls/updates properly
        messageController.selection = TextSelection.fromPosition(
          TextPosition(offset: newText.length),
        );
      },
    );
  }

  /// Stop voice recording
  void _stopRecording() {
    isRecording.value = false;
    _speech.stop();
  }

  /// Handle back button press
  void goBack(BuildContext context) {
    // Attempt to refresh journey list if instantiated
    try {
      if (Get.isRegistered<JourneyController>()) {
        Get.find<JourneyController>().refreshReflections();
      }
    } catch (_) {}
    
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppPath.home);
    }
  }
}

/// Chat Message Model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}