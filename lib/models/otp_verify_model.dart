class OtpVerifyRequestModel {
  final String email;
  final String code;

  const OtpVerifyRequestModel({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}

class OtpVerifyResponseModel {
  final String message;
  final String access;
  final String refresh;

  const OtpVerifyResponseModel({
    required this.message,
    required this.access,
    required this.refresh,
  });

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponseModel(
      message: json['message']?.toString() ?? 'Email verified',
      access: json['access']?.toString() ?? '',
      refresh: json['refresh']?.toString() ?? '',
    );
  }
}
