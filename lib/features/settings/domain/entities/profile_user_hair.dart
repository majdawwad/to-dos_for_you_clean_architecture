import 'package:equatable/equatable.dart';

class ProfileUserHair extends Equatable {
  final String color;
  final String type;

  const ProfileUserHair({
    required this.color,
    required this.type,
  });

  @override
  List<Object?> get props => [color, type];
}
