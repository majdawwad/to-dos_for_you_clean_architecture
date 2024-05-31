import 'package:dartz/dartz.dart';

import '../../../../core/constants/type_def.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todos_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImplement implements TodosRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Todo>>> getAllTodos(
      [int skip = 5, int limit = 5]) async {
    if (await networkInfo.isConnected) {
      try {
        final List<TodoModel> remoteTodos =
            await remoteDataSource.getAllTodos();
        localDataSource.cacheTodos(remoteTodos);
        return Right(remoteTodos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<TodoModel> localTodos =
            await localDataSource.getCachedTodos();
        return Right(localTodos);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo({required int todoId}) async {
    if (await networkInfo.isConnected) {
      try {
        final TodoModel remoteTodo =
            await remoteDataSource.getTodo(todoId: todoId);
        localDataSource.cacheTodo(remoteTodo);
        return Right(remoteTodo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final TodoModel localTodo = await localDataSource.getCachedTodo();
        return Right(localTodo);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addTodo({required Todo todo}) async {
    final TodoModel todoModel = TodoModel(todo: todo.todo, completed: false);
    return await _getPublicInfo(
      () {
        return remoteDataSource.addTodo(todoModel);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo({required int id}) async {
    return await _getPublicInfo(
      () {
        return remoteDataSource.deleteTodo(id);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateTodo({required Todo todo}) async {
    final TodoModel todoModel =
        TodoModel(id: todo.id, todo: todo.todo, completed: todo.completed);
    return await _getPublicInfo(
      () {
        return remoteDataSource.updateTodo(todoModel);
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
