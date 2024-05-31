import 'package:equatable/equatable.dart';

class ProfileUserAddress extends Equatable {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final String country;

  const ProfileUserAddress({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.country,
  });

  @override
  List<Object?> get props => [
        address,
        city,
        state,
        stateCode,
        postalCode,
        country,
      ];
}
