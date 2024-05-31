import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    super.id,
    required super.todo,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
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
