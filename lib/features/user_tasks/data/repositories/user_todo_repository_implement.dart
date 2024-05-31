import 'package:dartz/dartz.dart';

import '../../../../core/constants/type_def.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_todo.dart';
import '../../domain/repositories/user_todos_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/user_todo_model.dart';

class UserTodoRepositoryImplement implements UserTodosRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserTodoRepositoryImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserTodo>>> getUserTodos() async {
    if (await networkInfo.isConnected) {
      try {
        final List<UserTodoModel> remoteTodos =
            await remoteDataSource.getAllUserTodos();
        localDataSource.cacheUserTodos(remoteTodos);
        return Right(remoteTodos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<UserTodoModel> localTodos =
            await localDataSource.getCachedUserTodos();
        return Right(localTodos);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUserTodo(
      {required int userTodoId}) async {
    return await _getPublicInfo(
      () {
        return remoteDataSource.deleteUserTodo(userTodoId);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateUserTodo(
      {required UserTodo userTodo}) async {
    final UserTodoModel userTodoModel = UserTodoModel(
        id: userTodo.id, todo: userTodo.todo, completed: userTodo.completed);
    return await _getPublicInfo(
      () {
        return remoteDataSource.updateUserTodo(userTodoModel);
      },
    );
  }

  Future<Either<Failure, Unit>> _getPublicInfo(
      DeleteOrUpdateOrAddTodo deleteOrUpdateOrAddTodo) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddTodo();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
