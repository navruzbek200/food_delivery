import '../../domain/entities/confirm_email_entity.dart';

class ConfirmEmailModel extends ConfirmEmailEntity {
  ConfirmEmailModel({required String message}) : super(message: message);

  factory ConfirmEmailModel.fromJson(Map<String, dynamic> json) {
    return ConfirmEmailModel(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
