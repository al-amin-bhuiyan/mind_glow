import 'package:get/get.dart';

/// Journey Controller - Manages journey screen state and data
/// Follows OOP principles with proper encapsulation
class JourneyController extends GetxController {
  // ==================== Observable Properties ====================

  /// Total reflections count
  final RxInt reflectionsCount = 7.obs;

  /// Total themes explored count
  final RxInt themesExploredCount = 3.obs;

  /// Total days reflected
  final RxInt reflectedDaysCount = 6.obs;

  /// Selected filter option
  final RxString selectedFilter = 'All'.obs;

  /// Show/hide filter menu
  final RxBool showFilterMenu = false.obs;

  /// List of past reflections
  final RxList<ReflectionItem> reflections = <ReflectionItem>[].obs;

  // ==================== Constants ====================

  /// Available filter options
  final List<String> filterOptions = ['All', 'By Theme', 'By Time'];

  // ==================== Lifecycle Methods ====================

  @override
  void onInit() {
    super.onInit();
    _loadReflections();
  }

  // ==================== Private Methods ====================

  /// Load reflections from data source
  void _loadReflections() {
    // Mock data - Replace with actual API call or local storage
    reflections.value = [
      ReflectionItem(
        id: '1',
        date: 'April 12',
        theme: 'Self-Confident.',
        description: 'You reflected on moments where speaking up felt uncertain.',
      ),
      ReflectionItem(
        id: '2',
        date: 'April 12',
        theme: 'Self-Confident.',
        description: 'You considered how past experiences have shaped your sense of confidence.',
      ),
      ReflectionItem(
        id: '3',
        date: 'April 12',
        theme: 'Self-Confident.',
        description: 'You shared that sometimes you feel a weight in your sense of confidence.',
      ),
      ReflectionItem(
        id: '4',
        date: 'April 12',
        theme: 'Relationships.',
        description: 'You reflected on how feeling supported deepens your connections.',
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
      case 'By Theme':
      // Sort/filter by theme
        break;
      case 'By Time':
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
