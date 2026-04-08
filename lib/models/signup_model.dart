class SignupRequestModel {
  final String email;
  final String password;

  const SignupRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignupResponseModel {
  final String message;
  final String email;

  const SignupResponseModel({
    required this.message,
    required this.email,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message']?.toString() ?? 'OTP sent to email',
      email: json['email']?.toString() ?? '',
    );
  }
}
