import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class AddTodoUseCase {
  final TodosRepository repository;

  AddTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(Todo todo) async {
    return await repository.addTodo(todo: todo);
  }
}
