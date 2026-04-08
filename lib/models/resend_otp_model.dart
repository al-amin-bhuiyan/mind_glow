class ResendOtpRequestModel {
  final String email;

  const ResendOtpRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ResendOtpResponseModel {
  final String message;

  const ResendOtpResponseModel({
    required this.message,
  });

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponseModel(
      message: json['message']?.toString() ?? 'OTP resent to your email.',
    );
  }
}
