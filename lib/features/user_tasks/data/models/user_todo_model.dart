import '../../domain/entities/user_todo.dart';

class UserTodoModel extends UserTodo {
  const UserTodoModel({
    super.id,
    required super.todo,
    required super.completed,
  });

  factory UserTodoModel.fromJson(Map<String, dynamic> json) {
    return UserTodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['todo'] = todo;
    data['completed'] = completed;

    return data;
  }
}
