import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';
import '../../services/journey_service.dart';
import '../../routes/app_path.dart';
import '../reflect_controller/reflect_controller.dart';

/// Journey Controller - Manages journey screen state and data
/// Follows OOP principles with proper encapsulation
class JourneyController extends GetxController {
  // ==================== Observable Properties ====================

  /// Total reflections count
  final RxInt reflectionsCount = 0.obs;

  /// Total themes explored count
  final RxInt themesExploredCount = 0.obs;

  /// Total days reflected
  final RxInt reflectedDaysCount = 0.obs;

  /// Selected filter option
  final RxString selectedFilter = 'filterAll'.obs;

  /// Show/hide filter menu
  final RxBool showFilterMenu = false.obs;

  /// Loading state for past reflections
  final RxBool isLoadingReflections = false.obs;

  /// List of past reflections
  final RxList<ReflectionItem> reflections = <ReflectionItem>[].obs;

  // ==================== Constants ====================

  /// Available filter options
  final List<String> filterOptions = ['filterAll', 'filterByTheme', 'filterByTime'];

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
    loadJourneyData();
  }

  // ==================== Public Methods ====================

  /// Load all journey data (stats and reflections) allowing external refresh
  void loadJourneyData() {
    _loadReflections();
    _fetchUserSummary();
  }

  // ==================== Private Methods ====================

  /// Fetch user summary data for stats
  Future<void> _fetchUserSummary() async {
    try {
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await AuthService.instance.getUserSummary(token: token);

      if (response.success && response.data != null) {
        reflectionsCount.value = response.data!.reflectionsCount;
        themesExploredCount.value = response.data!.learningsCount;
        reflectedDaysCount.value = response.data!.activeReflectionDays;
      }
    } catch (e) {
      debugPrint('Error fetching user summary in journey: $e');
    }
  }

  /// Load reflections from data source
  Future<void> _loadReflections() async {
    try {
      isLoadingReflections.value = true;
      if (reflections.isEmpty) {
        reflections.value = [ReflectionItem(id: 0, date: '', title: '', summary: '')];
      }
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await JourneyService.instance.getPastReflections(token: token);

      if (response.success && response.data != null) {
        reflections.value = response.data!;
      } else {
        // Mock data
        reflections.value = [
          ReflectionItem(
            id: 1,
            date: 'april12',
            title: 'selfConfident',
            summary: 'mockDesc1',
          ),
          ReflectionItem(
            id: 2,
            date: 'april12',
            title: 'selfConfident',
            summary: 'mockDesc2',
          ),
          ReflectionItem(
            id: 3,
            date: 'april12',
            title: 'selfConfident',
            summary: 'mockDesc3',
          ),
          ReflectionItem(
            id: 4,
            date: 'april12',
            title: 'relationships',
            summary: 'mockDesc4',
          ),
        ];
      }
    } catch (e) {
      debugPrint('Error loading past reflections: $e');
    } finally {
      isLoadingReflections.value = false;
    }
  }

  /// Toggle filter menu visibility
  void toggleFilterMenu() {
    showFilterMenu.value = !showFilterMenu.value;
  }

  /// Apply selected filter
  void applyFilter(String filter) {
    selectedFilter.value = filter;
    showFilterMenu.value = false;

    // Apply filtering logic here
    // For now, just updating the selected filter
    // In production, filter the reflections list based on selected option
    _applyFilterLogic(filter);
  }

  /// Apply filter logic to reflections list
  void _applyFilterLogic(String filter) {
    // TODO: Implement actual filtering logic
    // This could filter by theme, time, etc.
    switch (filter) {
      case 'filterByTheme':
      // Sort/filter by theme
        break;
      case 'filterByTime':
      // Sort/filter by time
        break;
      default:
      // Show all
        _loadReflections();
    }
  }

  /// Open reflection detail screen
  Future<void> openReflectionDetail(BuildContext context, ReflectionItem reflection) async {
    print('Opening reflection: ${reflection.id} - ${reflection.title}');
    final reflectController = Get.find<ReflectController>();
    
    // Clear and set IDs properly even before the API returns
    reflectController.currentConversationId = reflection.id;
    reflectController.messages.clear();
    
    await reflectController.loadExistingConversation(reflection.id);
    
    if (context.mounted) {
      context.push(AppPath.reflect);
    }
  }

  /// Refresh reflections data
  Future<void> refreshReflections() async {
    // TODO: Implement refresh logic
    // This could fetch latest data from API
    await _fetchUserSummary();
    await Future.delayed(const Duration(seconds: 1));
    _loadReflections();
  }
}

/// Model class for Reflection Item
/// Represents a single reflection entry
class ReflectionItem {
  final int id;
  final String date;
  final String title;
  final String summary;

  ReflectionItem({
    required this.id,
    required this.date,
    required this.title,
    required this.summary,
  });

  /// Factory constructor from JSON
  factory ReflectionItem.fromJson(Map<String, dynamic> json) {
    return ReflectionItem(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      date: json['date']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      summary: json['summary']?.toString() ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'summary': summary,
    };
  }
}