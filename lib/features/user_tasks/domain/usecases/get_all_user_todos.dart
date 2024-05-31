import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/user_todo.dart';
import '../repositories/user_todos_repository.dart';

class GetAllUserTodosUseCase {
  final UserTodosRepository repository;

  GetAllUserTodosUseCase(
    this.repository,
  );

  Future<Either<Failure, List<UserTodo>>> call() async {
    return await repository.getUserTodos();
  }
}
