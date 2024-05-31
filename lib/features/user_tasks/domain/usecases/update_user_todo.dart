import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user_todo.dart';
import '../repositories/user_todos_repository.dart';

class UpdateUserTodoUseCase {
  final UserTodosRepository repository;

  UpdateUserTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(UserTodo userTodo) async {
    return await repository.updateUserTodo(userTodo: userTodo);
  }
}
