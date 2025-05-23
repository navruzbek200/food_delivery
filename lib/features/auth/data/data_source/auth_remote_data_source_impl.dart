import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/core/network/dio_client.dart';
import 'package:food_delivery/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:food_delivery/features/auth/data/model/forgot_password_model.dart';
import 'package:food_delivery/features/auth/data/model/register_model.dart';
import 'package:food_delivery/features/auth/data/model/resend_code_model.dart';
import 'package:food_delivery/features/auth/data/model/reset_password_model.dart';
import 'package:food_delivery/features/auth/domain/entities/confirm_email_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/login_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/resend_code_entity.dart';
import 'package:food_delivery/features/auth/domain/entities/reset_password_entity.dart';
import 'package:logger/logger.dart';
import '../model/confirm_email_model.dart';
import '../model/login_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  var logger = Logger();

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<RegisterModel> register({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post(
      ApiUrls.register,
      data: {"email": email, "password": password},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("Register response: $response");
      return RegisterModel.fromJson(response.data);
    } else {
      throw Exception("Failed to get Register user info");
    }
  }

  @override
  Future<ConfirmEmailEntity> confirmEmail({required int code}) async {
    logger.i("code: $code");
    final response = await dioClient.post(
      ApiUrls.confirmEmail,
      data: {"code": code},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("confirmEmail ${response.data}");
      return ConfirmEmailModel.fromJson(response.data);
    } else {
      throw Exception("Confirm Email Error");
    }
  }

  @override
  Future<LoginEntity> login({required String email, required String password}) async{
    final response = await dioClient.post(ApiUrls.login, data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("Register response: $response");

      final token = response.data['Token'];
      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty!');
      }
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.setString('auth_token', token);
      if (!success) {
        throw Exception('Failed to save token to SharedPreferences');
      }
      await prefs.setString('auth_token', token);

      return LoginModel.fromJson(response.data);
    } else {
      throw Exception("Failed to get Login user info");
    }
  }



  @override
  Future<ForgotPasswordEntity> forgotPassword({required String email}) async{
    final response = await dioClient.post(ApiUrls.forgotPassword, data: {
      "email": email,
    });
        if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("Register response: $response");
      return ForgotPasswordModel.fromJson(response.data);
    } else {
    throw Exception("Failed to get Login user info");
    }
  }

  @override
  Future<ResetPasswordEntity> resetPassword({required String email, required String password}) async{
    final response = await dioClient.post(ApiUrls.resetPassword, data: {
      "email": email,
      "password": password,
    });
      if (response.statusCode == 200 || response.statusCode ==201) {
        logger.i("Reset password response: $response");
        return ResetPasswordModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get Reset password user info");
      }
  }

  @override
  Future<ResendCodeEntity> resendCode({required String email}) async{
    final response = await dioClient.post(ApiUrls.resendCode, data: {
      "email": email,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("Resend code response: $response");
      return ResendCodeModel.fromJson(response.data);
    } else {
      throw Exception("Failed to get Resend code");
    }
  }


}
