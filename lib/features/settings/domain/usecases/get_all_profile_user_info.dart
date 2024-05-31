import 'package:dartz/dartz.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user.dart';
import 'package:maidscc_todos_app/features/settings/domain/repositories/profile_user_repository.dart';

import '../../../../core/errors/failures/failures.dart';

class GetAllProfileUserInfoUseCase {
  final ProfileUserRepository repository;

  GetAllProfileUserInfoUseCase(
    this.repository,
  );

  Future<Either<Failure, ProfileUser>> call() async {
    return await repository.getAllProfileUserInfo();
  }
}
