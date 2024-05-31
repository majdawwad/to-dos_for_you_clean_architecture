import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:maidscc_todos_app/features/settings/data/models/profile_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';

abstract class RemoteDataSource {
  Future<ProfileUserModel> getAllProfileUserInfo();
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImplement({
    required this.client,
  });

  @override
  Future<ProfileUserModel> getAllProfileUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String tokenAuth = sharedPreferences.getString(token) ?? "";

    final response = await client.get(
      Uri.parse(
        "$baseUrlApi/auth/me",
      ),
      headers: {
        'Authorization': 'Bearer $tokenAuth',
      },
    );

    log("......profile user Item.......${response.body}");

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final profileUserDecodedJson = json.decode(response.body);
      final ProfileUserModel jsonToProfileUserModels =
          ProfileUserModel.fromJson(profileUserDecodedJson);
      return jsonToProfileUserModels;
    } else if (response.statusCode == 401) {
      throw RefreshLoginException();
    } else {
      throw ServerException();
    }
  }
}
