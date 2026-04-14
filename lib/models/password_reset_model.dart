class PasswordResetRequestModel {
  final String email;

  PasswordResetRequestModel({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class PasswordResetResponseModel {
  final String detail;

  PasswordResetResponseModel({required this.detail});

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      detail: json['detail']?.toString() ?? '',
    );
  }
}

class PasswordResetVerifyRequestModel {
  final String email;
  final String code;

  PasswordResetVerifyRequestModel({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}

class PasswordResetVerifyResponseModel {
  final String detail;

  PasswordResetVerifyResponseModel({required this.detail});

  factory PasswordResetVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetVerifyResponseModel(
      detail: json['detail']?.toString() ?? '',
    );
  }
}

class PasswordResetConfirmRequestModel {
  final String email;
  final String code;
  final String newPassword;
  final String confirmPassword;

  PasswordResetConfirmRequestModel({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}

class PasswordResetConfirmResponseModel {
  final String detail;

  PasswordResetConfirmResponseModel({required this.detail});

  factory PasswordResetConfirmResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetConfirmResponseModel(
      detail: json['detail']?.toString() ?? '',
    );
  }
}