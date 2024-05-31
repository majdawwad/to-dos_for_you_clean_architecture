import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/todo_model.dart';

abstract class LocalDataSource {
  Future<List<TodoModel>> getCachedTodos();
  Future<Unit> cacheTodos(List<TodoModel> todoModels);

  Future<TodoModel> getCachedTodo();
  Future<Unit> cacheTodo(TodoModel todoModel);
}

class LocalDataSourceImplement implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImplement({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cacheTodos(List<TodoModel> todoModels) {
    final List todoModelsToJson = todoModels
        .map<Map<String, dynamic>>(
          (todoModel) => todoModel.toJson(),
        )
        .toList();
    final String cachedAllTodos = json.encode(todoModelsToJson);
    sharedPreferences.setString(cachedTodos, cachedAllTodos);
    return Future.value(unit);
  }

  @override
  Future<List<TodoModel>> getCachedTodos() {
    final cachedTodosJsonString = sharedPreferences.getString(cachedTodos);
    if (cachedTodosJsonString != null) {
      final List todoModelsJsonData = json.decode(cachedTodosJsonString);
      final List<TodoModel> jsonDataToTodoModels = todoModelsJsonData
          .map<TodoModel>(
            (todoModelJsonData) => TodoModel.fromJson(todoModelJsonData),
          )
          .toList();
      return Future.value(jsonDataToTodoModels);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cacheTodo(TodoModel todoModel) {
    final todoModelsToJson = todoModel.toJson();
    final String cachedTodo = json.encode(todoModelsToJson);
    sharedPreferences.setString(cachedTodoo, cachedTodo);
    return Future.value(unit);
  }

  @override
  Future<TodoModel> getCachedTodo() {
    final cachedTodosJsonString = sharedPreferences.getString(cachedTodoo);
    if (cachedTodosJsonString != null) {
      final todoModelsJsonData = json.decode(cachedTodosJsonString);
      final TodoModel jsonDataToTodoModels =
          TodoModel.fromJson(todoModelsJsonData);
      return Future.value(jsonDataToTodoModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
