import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../services/inspiration_service.dart';
import '../../services/token_storage_service.dart';

/// Inspire Controller - Manages inspire screen state and data
/// Follows OOP principles with proper encapsulation
class InspireController extends GetxController {
  // ==================== Observable Properties ====================

  /// Selected category filter
  final RxString selectedCategory = 'categoryVoices'.obs;

  /// List of saved inspirations
  final RxList<InspirationItem> savedInspirations = <InspirationItem>[].obs;

  /// List of inspiration videos
  final RxList<VideoItem> inspirationVideos = <VideoItem>[].obs;

  /// Featured quote
  final Rx<FeaturedQuote> featuredQuote = FeaturedQuote(
    text: 'featuredQuoteText',
    subtitle: 'featuredQuoteSubtitle',
  ).obs;

  // ==================== Constants ====================

  /// Available category options
  final List<String> categories = ['categoryVoices', 'categoryMeaning', 'categoryPerspectives', 'categoryWhatMatters'];

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
    _loadSavedInspirations();
    _loadInspirationVideos();
    _fetchDailyQuote();
  }

  // ==================== Private Methods ====================

  Future<void> _fetchDailyQuote() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InspirationService.instance.getDailyQuote(token: token);

      if (response.success && response.data != null) {
        if (response.data!.quote.isNotEmpty) {
          featuredQuote.value = FeaturedQuote(
            text: response.data!.quote,
            subtitle: 'featuredQuoteSubtitle',
            author: response.data!.author,
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching daily quote in Inspire: $e');
    }
  }

  /// Load saved inspirations from data source
  void _loadSavedInspirations() {
    // Mock data - Replace with actual API call or local storage
    savedInspirations.value = [
      InspirationItem(
        id: '1',
        type: InspirationItemType.quote,
        title: 'mockInspireTitle',
        savedContext: 'mockContextPatience',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '2',
        type: InspirationItemType.roleModel,
        title: 'mockInspireTitle',
        savedContext: 'mockContextQuiet',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '3',
        type: InspirationItemType.roleModel,
        title: 'mockInspireTitle',
        savedContext: 'mockContextPatience',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '4',
        type: InspirationItemType.quote,
        title: 'mockInspireTitle',
        savedContext: 'mockContextAcceptance',
        isBookmarked: true,
      ),
    ];
  }

  /// Load inspiration videos from data source
  void _loadInspirationVideos() {
    // Mock data - Replace with actual API call or local storage
    inspirationVideos.value = [
      VideoItem(
        id: '1',
        thumbnailAsset: 'assets/images/video_thumb_1.png',
        videoUrl: 'https://example.com/video1.mp4',
        title: 'Inner Peace Journey',
      ),
      VideoItem(
        id: '2',
        thumbnailAsset: 'assets/images/video_thumb_2.png',
        videoUrl: 'https://example.com/video2.mp4',
        title: 'Mindfulness Practice',
      ),
      VideoItem(
        id: '3',
        thumbnailAsset: 'assets/images/video_thumb_3.png',
        videoUrl: 'https://example.com/video3.mp4',
        title: 'Self Discovery',
      ),
      VideoItem(
        id: '4',
        thumbnailAsset: 'assets/images/video_thumb_1.png',
        videoUrl: 'https://example.com/video4.mp4',
        title: 'Emotional Clarity',
      ),
    ];
  }

  // ==================== Public Methods ====================

  /// Select a category filter
  void selectCategory(String category) {
    selectedCategory.value = category;
    // TODO: Filter inspirations based on selected category
  }

  /// Toggle bookmark status for an inspiration
  void toggleBookmark(String inspirationId) {
    final index = savedInspirations.indexWhere((item) => item.id == inspirationId);
    if (index != -1) {
      savedInspirations[index] = savedInspirations[index].copyWith(
        isBookmarked: !savedInspirations[index].isBookmarked,
      );
      savedInspirations.refresh();
    }
  }

  /// Open video player
  void playVideo(VideoItem video) {
    // TODO: Implement video player navigation
    Get.snackbar(
      'Video',
      'Playing: ${video.title}',
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Open inspiration detail
  void openInspirationDetail(InspirationItem inspiration) {
    // TODO: Implement inspiration detail navigation
    Get.snackbar(
      'Inspiration',
      'Opening: ${inspiration.title}',
      snackPosition: SnackPosition.TOP,
    );
  }
}

// ==================== Model Classes ====================

/// Featured quote model
class FeaturedQuote {
  final String text;
  final String subtitle;
  final String author;

  FeaturedQuote({
    required this.text,
    required this.subtitle,
    this.author = '',
  });
}

/// Inspiration item type enum
enum InspirationItemType {
  quote,
  roleModel,
}

/// Inspiration item model
class InspirationItem {
  final String id;
  final InspirationItemType type;
  final String title;
  final String savedContext;
  final bool isBookmarked;

  InspirationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.savedContext,
    this.isBookmarked = false,
  });

  /// Get type label
  String get typeLabel {
    switch (type) {
      case InspirationItemType.quote:
        return 'typeQuote';
      case InspirationItemType.roleModel:
        return 'typeRoleModels';
    }
  }

  /// Copy with method for immutability
  InspirationItem copyWith({
    String? id,
    InspirationItemType? type,
    String? title,
    String? savedContext,
    bool? isBookmarked,
  }) {
    return InspirationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      savedContext: savedContext ?? this.savedContext,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

/// Video item model
class VideoItem {
  final String id;
  final String thumbnailAsset;
  final String videoUrl;
  final String title;

  VideoItem({
    required this.id,
    required this.thumbnailAsset,
    required this.videoUrl,
    required this.title,
  });
}