import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';

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

  /// List of past reflections
  final RxList<ReflectionItem> reflections = <ReflectionItem>[].obs;

  // ==================== Constants ====================

  /// Available filter options
  final List<String> filterOptions = ['filterAll', 'filterByTheme', 'filterByTime'];

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
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
  void _loadReflections() {
    // Mock data - Replace with actual API call or local storage
    reflections.value = [
      ReflectionItem(
        id: '1',
        date: 'april12',
        theme: 'selfConfident',
        description: 'mockDesc1',
      ),
      ReflectionItem(
        id: '2',
        date: 'april12',
        theme: 'selfConfident',
        description: 'mockDesc2',
      ),
      ReflectionItem(
        id: '3',
        date: 'april12',
        theme: 'selfConfident',
        description: 'mockDesc3',
      ),
      ReflectionItem(
        id: '4',
        date: 'april12',
        theme: 'relationships',
        description: 'mockDesc4',
      ),
    ];
  }

  // ==================== Public Methods ====================

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
  void openReflectionDetail(ReflectionItem reflection) {
    // Navigate to reflection detail screen
    // TODO: Add navigation when detail screen is ready
    // Get.toNamed(AppPath.reflectionDetail, arguments: reflection);
    print('Opening reflection: ${reflection.theme}');
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
  final String id;
  final String date;
  final String theme;
  final String description;
  final DateTime? createdAt;

  ReflectionItem({
    required this.id,
    required this.date,
    required this.theme,
    required this.description,
    this.createdAt,
  });

  /// Factory constructor from JSON
  factory ReflectionItem.fromJson(Map<String, dynamic> json) {
    return ReflectionItem(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      theme: json['theme'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'theme': theme,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}