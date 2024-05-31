import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<Todo>>> getAllTodos(
      [int skip = 5, int limit = 5]);
  Future<Either<Failure, Todo>> getTodo({required int todoId});
  Future<Either<Failure, Unit>> deleteTodo({required int id});
  Future<Either<Failure, Unit>> updateTodo({required Todo todo});
  Future<Either<Failure, Unit>> addTodo({required Todo todo});
}
