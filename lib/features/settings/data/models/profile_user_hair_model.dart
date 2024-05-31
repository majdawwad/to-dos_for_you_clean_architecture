import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user_hair.dart';

class ProfileUserHairModel extends ProfileUserHair {
  const ProfileUserHairModel({
    required super.color,
    required super.type,
  });

  factory ProfileUserHairModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserHairModel(
      color: json['color'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['color'] = color;
    data['type'] = type;

    return data;
  }
}
