import 'package:dartz/dartz.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user.dart';

import '../../../../core/errors/failures/failures.dart';

abstract class ProfileUserRepository {
  Future<Either<Failure, ProfileUser>> getAllProfileUserInfo();
}
