class UserProfileModel {
  final int id;
  final String email;
  final String fullName;
  final String? profilePicture;
  final String pronouns;
  final String ageGroup;
  final String lifeSituation;
  final String occupation;
  final String lifeFeelings;
  final String faith;
  final String inspirationSources;
  final String attentionToday;
  final bool isEmailVerified;
  final bool isActive;

  const UserProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePicture,
    required this.pronouns,
    required this.ageGroup,
    required this.lifeSituation,
    required this.occupation,
    required this.lifeFeelings,
    required this.faith,
    required this.inspirationSources,
    required this.attentionToday,
    required this.isEmailVerified,
    required this.isActive,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int? ?? 0,
      email: json['email']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      profilePicture: json['profile_picture']?.toString(),
      pronouns: json['pronouns']?.toString() ?? '',
      ageGroup: json['age_group']?.toString() ?? '',
      lifeSituation: json['life_situation']?.toString() ?? '',
      occupation: json['occupation']?.toString() ?? '',
      lifeFeelings: json['life_feelings']?.toString() ?? '',
      faith: json['faith']?.toString() ?? '',
      inspirationSources: json['inspiration_sources']?.toString() ?? '',
      attentionToday: json['attention_today']?.toString() ?? '',
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? false,
    );
  }
}
