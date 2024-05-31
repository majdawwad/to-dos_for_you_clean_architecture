import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/todo_model.dart';

abstract class RemoteDataSource {
  Future<List<TodoModel>> getAllTodos([int skip = 5, int limit = 5]);
  Future<TodoModel> getTodo({required int todoId});
  Future<Unit> deleteTodo(int todoId);
  Future<Unit> updateTodo(TodoModel todoModel);
  Future<Unit> addTodo(TodoModel todoModel);
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImplement({
    required this.client,
  });

  @override
  Future<List<TodoModel>> getAllTodos([int skip = 5, int limit = 5]) async {
    final response = await client.get(
      Uri.parse(
        "$baseUrlApi/todos?limit=$limit&skip=$skip",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    log("......todos.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final todosDecodedJson = json.decode(response.body);
      final todos = todosDecodedJson['todos'] as List;
      final List<TodoModel> jsonToTodoModels = todos
          .map<TodoModel>(
            (todoModel) => TodoModel.fromJson(todoModel),
          )
          .toList();
      return jsonToTodoModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getTodo({required int todoId}) async {
    final response = await client.get(
      Uri.parse(
        "$baseUrlApi/todos/$todoId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    log("......todo Item.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final todosDecodedJson = json.decode(response.body);
      final TodoModel jsonToTodoModels = TodoModel.fromJson(todosDecodedJson);
      return jsonToTodoModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addTodo(TodoModel todoModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = sharedPreferences.getInt(userIds) ?? 0;

    final Map<String, dynamic> body = {
      "todo": todoModel.todo,
      "completed": todoModel.completed,
      "userId": userId,
    };

    final bodyEncoded = json.encode(body);

    final response = await client.post(
      Uri.parse("$baseUrlApi/todos/add"),
      body: bodyEncoded,
      headers: {'Content-Type': 'application/json'},
    );

    log("......add todo.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteTodo(int todoId) async {
    final response = await client.delete(
      Uri.parse("$baseUrlApi/todos/$todoId"),
    );

    log("......delete todo.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateTodo(TodoModel todoModel) async {
    final String todoId = todoModel.id.toString();

    final Map<String, dynamic> body = {
      "completed": todoModel.completed,
    };

    final bodyEncoded = json.encode(body);

    final response = await client.patch(
      Uri.parse("$baseUrlApi/todos/$todoId"),
      body: bodyEncoded,
      headers: {'Content-Type': 'application/json'},
    );

    log("......update todo.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
