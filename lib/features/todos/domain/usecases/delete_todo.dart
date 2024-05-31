import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../repositories/todos_repository.dart';

class DeleteTodoUseCase {
  final TodosRepository repository;

  DeleteTodoUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(int todoId) async {
    return await repository.deleteTodo(id: todoId);
  }
}
