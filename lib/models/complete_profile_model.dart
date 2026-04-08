class CompleteProfileRequestModel {
  final String fullName;
  final String ageGroup;
  final String lifeSituation;
  final String occupation;
  final String lifeFeelings;
  final String faith;
  final String inspirationSources;
  final String attentionToday;

  const CompleteProfileRequestModel({
    required this.fullName,
    required this.ageGroup,
    required this.lifeSituation,
    required this.occupation,
    required this.lifeFeelings,
    required this.faith,
    required this.inspirationSources,
    required this.attentionToday,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'age_group': ageGroup,
      'life_situation': lifeSituation,
      'occupation': occupation,
      'life_feelings': lifeFeelings,
      'faith': faith,
      'inspiration_sources': inspirationSources,
      'attention_today': attentionToday,
    };
  }
}

class CompleteProfileResponseModel {
  final String message;

  const CompleteProfileResponseModel({
    required this.message,
  });

  factory CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponseModel(
      message: json['message']?.toString() ?? 'Profile updated',
    );
  }
}