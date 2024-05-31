import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../repositories/user_todos_repository.dart';

class DeleteUserTodoUseCase {
  final UserTodosRepository repository;

  DeleteUserTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(int userTodoId) async {
    return await repository.deleteUserTodo(userTodoId: userTodoId);
  }
}
