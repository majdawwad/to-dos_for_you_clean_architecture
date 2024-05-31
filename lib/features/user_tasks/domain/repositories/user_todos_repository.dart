import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user_todo.dart';

abstract class UserTodosRepository {
  Future<Either<Failure, List<UserTodo>>> getUserTodos();
  Future<Either<Failure, Unit>> deleteUserTodo({required int userTodoId});
  Future<Either<Failure, Unit>> updateUserTodo({required UserTodo userTodo});
}
