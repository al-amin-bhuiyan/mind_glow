import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/inspiration_service.dart';
import '../../services/token_storage_service.dart';
import '../../views/inspire/widgets/youtube_player_screen.dart';

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

  /// Is featured quote bookmarked
  final RxBool isQuoteBookmarked = false.obs;
  
  /// Is bookmarking in progress
  final RxBool isBookmarking = false.obs;

  /// Show all quotes instead of just 4
  final RxBool showAllQuotes = false.obs;

  // ==================== Constants ====================

  /// Available category options (now observable to populate from API)
  final RxList<String> categories = <String>[].obs;

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
    _loadSavedInspirations();
    _loadInspirationVideos();
    _fetchDailyQuote();
    _fetchTopics();
  }

  // ==================== Private Methods ====================

  Future<void> _fetchTopics() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InspirationService.instance.getTopics(token: token);

      if (response.success && response.data != null) {
        categories.value = response.data!;
        if (categories.isNotEmpty && selectedCategory.value == 'categoryVoices') {
          selectedCategory.value = categories.first;
        }
      }
    } catch (e) {
      debugPrint('Error fetching topics in Inspire: $e');
    }
  }

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
          // reset bookmark state when fetching new quote
          isQuoteBookmarked.value = false;
        }
      }
    } catch (e) {
      debugPrint('Error fetching daily quote in Inspire: $e');
    }
  }

  /// Toggle bookmark for the featured quote
  Future<void> toggleQuoteBookmark() async {
    if (isBookmarking.value) return;
    
    final quoteData = featuredQuote.value;
    if (quoteData.text == 'featuredQuoteText' || quoteData.text.isEmpty) return;

    if (isQuoteBookmarked.value) {
      // Find the quote in saved inspirations to delete it
      final existingItem = savedInspirations.firstWhereOrNull(
        (item) => item.title == quoteData.text && item.author == quoteData.author
      );
      
      if (existingItem != null) {
        isBookmarking.value = true;
        // The toggleBookmark method already handles removing and API calls
        await toggleBookmark(existingItem.id);
        isQuoteBookmarked.value = false;
        isBookmarking.value = false;
      } else {
        isQuoteBookmarked.value = false;
      }
      return;
    }

    try {
      isBookmarking.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      
      // Optimistic UI update
      isQuoteBookmarked.value = true;
      final optimisticId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      savedInspirations.insert(0, InspirationItem(
        id: optimisticId,
        type: InspirationItemType.quote,
        title: quoteData.text,
        savedContext: '',
        isBookmarked: true,
        author: quoteData.author,
      ));
      
      final response = await InspirationService.instance.favoriteQuote(
        quote: quoteData.text,
        author: quoteData.author,
        token: token,
      );

      if (response.success) {
        _loadSavedInspirations(); // Reload from server to get correct ID
        Fluttertoast.showToast(
          msg: "Quote bookmarked successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // Revert on failure
        isQuoteBookmarked.value = false;
        savedInspirations.removeWhere((item) => item.id == optimisticId);
        Fluttertoast.showToast(
          msg: response.errorMessage ?? "Failed to bookmark quote.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      isQuoteBookmarked.value = false;
      savedInspirations.removeWhere((item) => item.id.startsWith('temp_'));
      debugPrint('Error bookmarking quote: $e');
      Fluttertoast.showToast(
        msg: "An error occurred while bookmarking.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isBookmarking.value = false;
    }
  }

  /// Load saved inspirations from data source
  Future<void> _loadSavedInspirations() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InspirationService.instance.getFavoriteQuotes(token: token);

      if (response.success && response.data != null) {
        savedInspirations.value = response.data!
            .map((json) => InspirationItem(
                  id: (json['id'] ?? '').toString(),
                  type: InspirationItemType.quote,
                  title: json['quote']?.toString() ?? '',
                  savedContext: '',
                  isBookmarked: true,
                  author: json['author']?.toString() ?? 'Unknown Author',
                ))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching favorite quotes: $e');
    }
  }

  /// Load inspiration videos from data source
  Future<void> _loadInspirationVideos() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await InspirationService.instance.getInspirationVideos(token: token);

      if (response.success && response.data != null) {
        inspirationVideos.value = response.data!
            .map((json) => VideoItem.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching inspiration videos: $e');
    }
  }

  // ==================== Public Methods ====================

  /// Select a category filter
  void selectCategory(String category) {
    selectedCategory.value = category;
    // TODO: Filter inspirations based on selected category
  }

  /// Toggle bookmark status for an inspiration (removes it since it's already in the favorites)
  Future<void> toggleBookmark(String inspirationId) async {
    final index = savedInspirations.indexWhere((item) => item.id == inspirationId);
    if (index != -1) {
      final removedItem = savedInspirations[index];
      
      // Optimistically remove from UI
      savedInspirations.removeAt(index);
      
      try {
        final token = await TokenStorageService.instance.getAccessToken();
        final response = await InspirationService.instance.removeFavoriteQuote(
          id: inspirationId, 
          token: token,
        );
        
        if (response.success) {
          Fluttertoast.showToast(
            msg: "Quote removed from favorites.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          // Revert on failure
          savedInspirations.insert(index, removedItem);
          Fluttertoast.showToast(
            msg: response.errorMessage ?? "Failed to remove quote.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        // Revert on failure
        savedInspirations.insert(index, removedItem);
        debugPrint('Error removing quote: $e');
        Fluttertoast.showToast(
          msg: "An error occurred while removing the quote.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  /// Toggle showing all quotes
  void toggleShowAllQuotes() {
    showAllQuotes.value = !showAllQuotes.value;
  }

  /// Open video player
  void playVideo(BuildContext context, VideoItem video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YoutubePlayerScreen(
          videoUrl: video.videoUrl,
          title: video.title,
        ),
      ),
    );
  }

  /// Open inspiration detail
  void openInspirationDetail(BuildContext context, InspirationItem inspiration) {
    // The info_popup automatically intercepts the click trigger on the InspirationCard itself.
    // We no longer display the fluttertoast here.
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
  final String? author;

  InspirationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.savedContext,
    this.isBookmarked = false,
    this.author,
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
    String? author,
  }) {
    return InspirationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      savedContext: savedContext ?? this.savedContext,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      author: author ?? this.author,
    );
  }
}

/// Video item model
class VideoItem {
  final String title;
  final String videoUrl;
  final String description;
  final String channel;
  final String thumbnailAsset;
  final String publishedAt;

  VideoItem({
    required this.title,
    required this.videoUrl,
    required this.description,
    required this.channel,
    required this.thumbnailAsset,
    required this.publishedAt,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      title: json['title'] ?? '',
      videoUrl: json['url'] ?? '',
      description: json['description'] ?? '',
      channel: json['channel'] ?? '',
      thumbnailAsset: json['thumbnail'] ?? '',
      publishedAt: json['published_at'] ?? '',
    );
  }
}