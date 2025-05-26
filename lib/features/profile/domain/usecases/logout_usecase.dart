import 'package:food_delivery/features/profile/domain/entities/logout_entity.dart';
import 'package:food_delivery/features/profile/domain/repositories/profile_repository.dart';

class LogoutUsecase {
  final ProfileRepository profileRepository;

  LogoutUsecase({required this.profileRepository});

  Future<LogoutEntity> call() {
    return profileRepository.logout();
  }
}
