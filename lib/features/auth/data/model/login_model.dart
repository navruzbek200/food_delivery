import 'package:food_delivery/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required String Token,
    required String message
  }) : super(
      Token: Token,
      message: message
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    print("LoginModel.fromJson json: $json");
    return LoginModel(
      Token: json['Token'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
