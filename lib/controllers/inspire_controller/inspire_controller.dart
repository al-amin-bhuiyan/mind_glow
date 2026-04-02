import 'package:get/get.dart';

/// Inspire Controller - Manages inspire screen state and data
/// Follows OOP principles with proper encapsulation
class InspireController extends GetxController {
  // ==================== Observable Properties ====================

  /// Selected category filter
  final RxString selectedCategory = 'Voices'.obs;

  /// List of saved inspirations
  final RxList<InspirationItem> savedInspirations = <InspirationItem>[].obs;

  /// List of inspiration videos
  final RxList<VideoItem> inspirationVideos = <VideoItem>[].obs;

  /// Featured quote
  final Rx<FeaturedQuote> featuredQuote = FeaturedQuote(
    text: '"Not everything that feels unresolved need immediate clarity."',
    subtitle: 'Chosen based on what resonates with you',
  ).obs;

  // ==================== Constants ====================

  /// Available category options
  final List<String> categories = ['Voices', 'Meaning', 'Perspectives', 'What Matters'];

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
    _loadSavedInspirations();
    _loadInspirationVideos();
  }

  // ==================== Private Methods ====================

  /// Load saved inspirations from data source
  void _loadSavedInspirations() {
    // Mock data - Replace with actual API call or local storage
    savedInspirations.value = [
      InspirationItem(
        id: '1',
        type: InspirationItemType.quote,
        title: 'Sometimes clarity arrives\nwhen we stop pushing \nfor it.',
        savedContext: 'Save during a reflection on patience',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '2',
        type: InspirationItemType.roleModel,
        title: 'Sometimes clarity arrives\nwhen we stop pushing \nfor it.',
        savedContext: 'Save after a quite moments',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '3',
        type: InspirationItemType.roleModel,
        title: 'Sometimes clarity arrives\nwhen we stop pushing \nfor it.',
        savedContext: 'Save during a reflection on patience',
        isBookmarked: true,
      ),
      InspirationItem(
        id: '4',
        type: InspirationItemType.quote,
        title: 'Sometimes clarity arrives\nwhen we stop pushing \nfor it.',
        savedContext: 'Save during a reflection on acceptance',
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

  FeaturedQuote({
    required this.text,
    required this.subtitle,
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
        return 'Quote';
      case InspirationItemType.roleModel:
        return 'Role Models';
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
