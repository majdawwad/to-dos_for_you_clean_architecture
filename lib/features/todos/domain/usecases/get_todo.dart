import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class GetTodoUseCase {
  final TodosRepository repository;

  GetTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Todo>> call({required int todoId}) async {
    return await repository.getTodo(todoId: todoId);
  }
}
