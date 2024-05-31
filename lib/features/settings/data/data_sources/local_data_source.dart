import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:maidscc_todos_app/features/settings/data/models/profile_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';

abstract class LocalDataSource {
  Future<ProfileUserModel> getCachedAllProfileUserInfo();
  Future<Unit> cacheAllProfileUserInfo(ProfileUserModel profileUserModel);
}

class LocalDataSourceImplement implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImplement({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cacheAllProfileUserInfo(ProfileUserModel profileUserModel) {
    final profileUserModelToJson = profileUserModel.toJson();
    final String cachedProfileUserModel = json.encode(profileUserModelToJson);
    sharedPreferences.setString(cachedProfileUser, cachedProfileUserModel);
    return Future.value(unit);
  }

  @override
  Future<ProfileUserModel> getCachedAllProfileUserInfo() {
    final cachedProfileUserJsonString =
        sharedPreferences.getString(cachedProfileUser);
    if (cachedProfileUserJsonString != null) {
      final profileUserModelsJsonData =
          json.decode(cachedProfileUserJsonString);
      final ProfileUserModel jsonDataToProfileUserModels =
          ProfileUserModel.fromJson(profileUserModelsJsonData);
      return Future.value(jsonDataToProfileUserModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
