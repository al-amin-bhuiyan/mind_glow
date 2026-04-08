class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class LoginUserModel {
  final int id;
  final String email;
  final bool isSuperuser;

  const LoginUserModel({
    required this.id,
    required this.email,
    required this.isSuperuser,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      isSuperuser: json['is_superuser'] as bool? ?? false,
    );
  }
}

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final LoginUserModel user;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access'] as String? ?? '',
      refreshToken: json['refresh'] as String? ?? '',
      user: LoginUserModel.fromJson(
          json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}
