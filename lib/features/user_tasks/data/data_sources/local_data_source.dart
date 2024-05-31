import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/user_todo_model.dart';

abstract class LocalDataSource {
  Future<List<UserTodoModel>> getCachedUserTodos();
  Future<Unit> cacheUserTodos(List<UserTodoModel> userTodoModels);
}

class LocalDataSourceImplement implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImplement({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cacheUserTodos(List<UserTodoModel> userTodoModels) {
    final List userTodoModelsToJson = userTodoModels
        .map<Map<String, dynamic>>(
          (userTodoModel) => userTodoModel.toJson(),
        )
        .toList();
    final String cachedAllUserTodos = json.encode(userTodoModelsToJson);
    sharedPreferences.setString(cachedUserTodos, cachedAllUserTodos);
    return Future.value(unit);
  }

  @override
  Future<List<UserTodoModel>> getCachedUserTodos() {
    final cachedUserTodosJsonString =
        sharedPreferences.getString(cachedUserTodos);
    if (cachedUserTodosJsonString != null) {
      final List userTodoModelsJsonData =
          json.decode(cachedUserTodosJsonString);
      final List<UserTodoModel> jsonDataToUserodoModels = userTodoModelsJsonData
          .map<UserTodoModel>(
            (todoModelJsonData) => UserTodoModel.fromJson(todoModelJsonData),
          )
          .toList();
      return Future.value(jsonDataToUserodoModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
