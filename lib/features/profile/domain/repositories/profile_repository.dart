import '../entities/logout_entity.dart';

abstract class ProfileRepository {

  Future<LogoutEntity> logout();


}
