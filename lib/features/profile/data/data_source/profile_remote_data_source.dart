import '../../domain/entities/logout_entity.dart';

abstract class ProfileRemoteDataSource {

  Future<LogoutEntity> logout();

}