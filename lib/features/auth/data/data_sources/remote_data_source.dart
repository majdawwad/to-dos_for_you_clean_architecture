import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> signIn(UserModel userModel);
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  RemoteDataSourceImplement({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> signIn(UserModel userModel) async {
    final Map<String, dynamic> body = {
      "username": userModel.username,
      "password": userModel.password,
      'expiresInMins': userModel.expiresInMins,
    };

    final reqBody = json.encode(body);

    final response = await client
        .post(Uri.parse("$baseUrlApi/auth/login"), body: reqBody, headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final userJsonDecoded = json.decode(response.body);

      final userModelJson = UserModel.fromJson(userJsonDecoded);

      log(userModelJson.toJson().toString());
      sharedPreferences.setString(token, userModelJson.token!);
      sharedPreferences.setInt(userIds, userModelJson.id!);
      return (userModelJson);
    } else if (response.statusCode == 402 || response.statusCode == 400) {
      throw CredentionalsException();
    } else {
      throw ServerException();
    }
  }
}
