import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user_address.dart';

class ProfileUserAddressModel extends ProfileUserAddress {
  const ProfileUserAddressModel(
      {required super.address,
      required super.city,
      required super.state,
      required super.country,
      required super.postalCode,
      required super.stateCode});

  factory ProfileUserAddressModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserAddressModel(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      stateCode: json['stateCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateCode'] = stateCode;
    data['postalCode'] = postalCode;
    data['country'] = country;

    return data;
  }
}
