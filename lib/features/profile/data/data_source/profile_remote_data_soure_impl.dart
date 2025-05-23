import 'package:dio/dio.dart';
import 'package:food_delivery/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:logger/logger.dart';
import '../../../../core/common/constants/api_url.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/token_storage.dart';
import '../../domain/entities/logout_entity.dart';
import '../model/logout_model.dart';

class ProfileRemoteDataSoureImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;
  final TokenStorage tokenStorage;
  var logger = Logger();

  ProfileRemoteDataSoureImpl({required this.dioClient, required this.tokenStorage});

  @override
  Future<LogoutEntity> logout() async{
    final token = await tokenStorage.getToken();
    final response = await dioClient.post(
      ApiUrls.logout,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      await tokenStorage.removeToken();
      logger.i("Logout response: $response");
      return LogoutModel.fromJson(response.data);
    } else {
      throw Exception("Failed to logout");
    }
  }
}
