import 'package:equatable/equatable.dart';

import 'profile_user_address.dart';

class ProfileUserCompany extends Equatable {
  final String department;
  final String name;
  final String title;
  final ProfileUserAddress address;

  const ProfileUserCompany({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  @override
  List<Object?> get props => [department, name, title, address];
}
