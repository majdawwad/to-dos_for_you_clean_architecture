import 'package:equatable/equatable.dart';

class UserTodo extends Equatable {
  final int? id;
  final String todo;
  final bool completed;

  const UserTodo({
    this.id,
    required this.todo,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, todo, completed];
}
