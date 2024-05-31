import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String todo;
  final bool completed;

  const Todo({
    this.id,
    required this.todo,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, todo, completed];
}
