import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user_company.dart';

import '../../domain/entities/profile_user_address.dart';
import 'profile_user_address_model.dart';

class ProfileUserCompanyModel extends ProfileUserCompany {
  const ProfileUserCompanyModel(
      {required super.address,
      required super.department,
      required super.name,
      required super.title});

  factory ProfileUserCompanyModel.fromJson(Map<String, dynamic> json) {
    ProfileUserAddressModel profileUserAddressComModel =
        ProfileUserAddressModel.fromJson(json['address']);
    return ProfileUserCompanyModel(
      address: json['address'] != null
          ? ProfileUserAddress(
              address: profileUserAddressComModel.address,
              city: profileUserAddressComModel.city,
              state: profileUserAddressComModel.state,
              stateCode: profileUserAddressComModel.stateCode,
              postalCode: profileUserAddressComModel.postalCode,
              country: profileUserAddressComModel.country,
            )
          : const ProfileUserAddress(
              address: "address",
              city: "city",
              state: "state",
              stateCode: "stateCode",
              postalCode: "postalCode",
              country: "country",
            ),
      department: json['department'],
      name: json['name'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['department'] = department;
    data['name'] = name;
    data['title'] = title;
    data['address'] = address;

    return data;
  }
}
