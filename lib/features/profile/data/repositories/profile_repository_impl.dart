import 'package:food_delivery/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:food_delivery/features/profile/domain/repositories/profile_repository.dart';
import '../../domain/entities/logout_entity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<LogoutEntity> logout() {
    return profileRemoteDataSource.logout();
  }
}