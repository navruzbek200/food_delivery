import 'package:food_delivery/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({required super.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      RegisterModel(message: json["message"] ?? 0);

}
