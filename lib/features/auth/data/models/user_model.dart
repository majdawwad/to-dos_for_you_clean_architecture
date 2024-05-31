import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    super.username,
    super.password,
    super.expiresInMins,
    super.firstName,
    super.lastName,
    super.email,
    super.gender,
    super.userImage,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      userImage: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['image'] = userImage;
    data['token'] = token;
    return data;
  }
}
