import 'package:food_delivery/features/auth/domain/entities/resend_code_entity.dart';

class ResendCodeModel extends ResendCodeEntity{
  ResendCodeModel({required super.message});

  factory ResendCodeModel.fromJson(Map<String, dynamic>json){
    return ResendCodeModel(message: json["message"]?? '');
  }
}