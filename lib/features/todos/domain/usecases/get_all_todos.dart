import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class GetAllTodosUseCase {
  final TodosRepository repository;

  GetAllTodosUseCase(
    this.repository,
  );

  Future<Either<Failure, List<Todo>>> call(
      [int skip = 5, int limit = 5]) async {
    return await repository.getAllTodos();
  }
}
