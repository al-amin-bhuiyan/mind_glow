/// Request model for Contact Support
class ContactSupportRequestModel {
  final String subject;
  final String email;
  final String message;

  const ContactSupportRequestModel({
    required this.subject,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'subject': subject,
    'email': email,
    'message': message,
  };
}

/// Response model for Contact Support
class ContactSupportResponseModel {
  final int id;
  final String subject;
  final String email;
  final String message;
  final DateTime? createdAt;

  const ContactSupportResponseModel({
    required this.id,
    required this.subject,
    required this.email,
    required this.message,
    this.createdAt,
  });

  factory ContactSupportResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactSupportResponseModel(
      id: json['id'] as int? ?? 0,
      subject: json['subject'] as String? ?? '',
      email: json['email'] as String? ?? '',
      message: json['message'] as String? ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
    );
  }
}
