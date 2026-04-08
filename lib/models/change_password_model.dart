/// Request model for Change Password
class ChangePasswordRequestModel {
  final String oldPassword;
  final String newPassword1;
  final String newPassword2;

  const ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword1,
    required this.newPassword2,
  });

  Map<String, dynamic> toJson() => {
    'old_password': oldPassword,
    'new_password1': newPassword1,
    'new_password2': newPassword2,
  };
}

/// Response model for Change Password
class ChangePasswordResponseModel {
  final String detail;

  const ChangePasswordResponseModel({
    required this.detail,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      detail: json['detail'] as String? ?? 'Password has been saved.',
    );
  }
}
