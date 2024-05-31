import 'package:dartz/dartz.dart';
import 'package:maidscc_todos_app/core/errors/failures/failures.dart';
import 'package:maidscc_todos_app/features/settings/data/models/profile_user_model.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user.dart';
import 'package:maidscc_todos_app/features/settings/domain/repositories/profile_user_repository.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_date_source.dart';

class ProfileUserRepositoryImplement implements ProfileUserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileUserRepositoryImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileUser>> getAllProfileUserInfo() async {
    if (await networkInfo.isConnected) {
      try {
        final ProfileUserModel remoteProfileUser =
            await remoteDataSource.getAllProfileUserInfo();
        localDataSource.cacheAllProfileUserInfo(remoteProfileUser);
        return Right(remoteProfileUser);
      } on RefreshLoginException {
        return Left(RefreshLoginFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final ProfileUserModel localProfileUser =
            await localDataSource.getCachedAllProfileUserInfo();
        return Right(localProfileUser);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
