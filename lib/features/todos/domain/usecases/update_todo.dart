import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class UpdateTodoUseCase {
  final TodosRepository repository;

  UpdateTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(Todo todo) async {
    return await repository.updateTodo(todo: todo);
  }
}
