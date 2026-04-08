/// Response model for User Summary
class UserSummaryResponseModel {
  final int reflectionsCount;
  final int learningsCount;
  final int activeReflectionDays;

  const UserSummaryResponseModel({
    required this.reflectionsCount,
    required this.learningsCount,
    required this.activeReflectionDays,
  });

  factory UserSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return UserSummaryResponseModel(
      reflectionsCount: json['reflections_count'] as int? ?? 0,
      learningsCount: json['learnings_count'] as int? ?? 0,
      activeReflectionDays: json['active_reflection_days'] as int? ?? 0,
    );
  }
}
