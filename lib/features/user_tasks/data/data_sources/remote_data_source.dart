import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/user_todo_model.dart';

abstract class RemoteDataSource {
  Future<List<UserTodoModel>> getAllUserTodos();
  Future<Unit> deleteUserTodo(int userTodoId);
  Future<Unit> updateUserTodo(UserTodoModel userTodoModel);
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImplement({
    required this.client,
  });

  @override
  Future<List<UserTodoModel>> getAllUserTodos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = sharedPreferences.getInt(userIds) ?? 0;

    final response = await client.get(
      Uri.parse(
        "$baseUrlApi/todos/user/$userId",
      ),
    );

    log("......user todos.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final todosDecodedJson = json.decode(response.body);
      final todos = todosDecodedJson['todos'] as List;
      final List<UserTodoModel> jsonToTodoModels = todos
          .map<UserTodoModel>(
            (todoModel) => UserTodoModel.fromJson(todoModel),
          )
          .toList();
      return jsonToTodoModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUserTodo(int userTodoId) async {
    final response = await client.delete(
      Uri.parse("$baseUrlApi/todos/$userTodoId"),
    );

    log("......delete user todo.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateUserTodo(UserTodoModel userTodoModel) async {
    final String userTodoId = userTodoModel.id.toString();

    final Map<String, dynamic> body = {
      "completed": userTodoModel.completed,
    };

    final bodyEncoded = json.encode(body);

    final response = await client.patch(
      Uri.parse("$baseUrlApi/todos/$userTodoId"),
      body: bodyEncoded,
      headers: {'Content-Type': 'application/json'},
    );

    log("......update user todo.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
