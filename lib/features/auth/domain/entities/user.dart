import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? password;
  final int? expiresInMins;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? userImage;
  final String? token;

  const User({
    this.id,
    this.username,
    this.password,
    this.expiresInMins,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.userImage,
    this.token,
  });

  @override
  List<Object?> get props =>
      [id, username, email, firstName, lastName, gender, userImage, token];
}
