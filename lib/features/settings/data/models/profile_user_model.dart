import 'package:maidscc_todos_app/features/settings/data/models/profile_user_address_model.dart';
import 'package:maidscc_todos_app/features/settings/data/models/profile_user_company_model.dart';
import 'package:maidscc_todos_app/features/settings/data/models/profile_user_hair_model.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user_company.dart';
import 'package:maidscc_todos_app/features/settings/domain/entities/profile_user_hair.dart';

import '../../domain/entities/profile_user_address.dart';

class ProfileUserModel extends ProfileUser {
  const ProfileUserModel({
    required super.firstName,
    required super.lastName,
    required super.address,
    required super.age,
    required super.birthDate,
    required super.bloodGroup,
    required super.company,
    required super.email,
    required super.eyeColor,
    required super.gender,
    required super.hair,
    required super.height,
    required super.image,
    required super.maidenName,
    required super.phone,
    required super.role,
    required super.university,
    required super.userId,
    required super.userName,
    required super.weight,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    ProfileUserAddressModel profileUserAddressModel =
        ProfileUserAddressModel.fromJson(json['address']);
    ProfileUserCompanyModel profileUserCompanyModel =
        ProfileUserCompanyModel.fromJson(json['company']);

    ProfileUserHairModel profileUserHairModel =
        ProfileUserHairModel.fromJson(json['hair']);
    return ProfileUserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'] != null
          ? ProfileUserAddress(
              address: profileUserAddressModel.address,
              city: profileUserAddressModel.city,
              state: profileUserAddressModel.state,
              stateCode: profileUserAddressModel.stateCode,
              postalCode: profileUserAddressModel.postalCode,
              country: profileUserAddressModel.country,
            )
          : const ProfileUserAddress(
              address: "address",
              city: "city",
              state: "state",
              stateCode: "stateCode",
              postalCode: "postalCode",
              country: "country",
            ),
      age: json['age'],
      birthDate: json['birthDate'],
      bloodGroup: json['bloodGroup'],
      company: json['company'] != null
          ? ProfileUserCompany(
              department: profileUserCompanyModel.department,
              name: profileUserCompanyModel.name,
              title: profileUserCompanyModel.title,
              address: profileUserCompanyModel.address,
            )
          : const ProfileUserCompany(
              department: "department",
              name: "name",
              title: "title",
              address: ProfileUserAddress(
                address: "address",
                city: "city",
                state: "state",
                stateCode: "stateCode",
                postalCode: "postalCode",
                country: "country",
              ),
            ),
      email: json['email'],
      eyeColor: json['eyeColor'],
      gender: json['gender'],
      hair: json['hair'] != null
          ? ProfileUserHair(
              color: profileUserHairModel.color,
              type: profileUserHairModel.type,
            )
          : const ProfileUserHair(
              color: "color",
              type: "type",
            ),
      height: json['height'],
      image: json['image'],
      maidenName: json['maidenName'],
      phone: json['phone'],
      role: json['role'],
      university: json['university'],
      userId: json['id'],
      userName: json['username'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['maidenName'] = maidenName;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = userName;
    data['birthDate'] = birthDate;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['eyeColor'] = eyeColor;
    data['hair'] = {
      'color': hair.color,
      'type': hair.type,
    };
    data['address'] = {
      'address': address.address,
      'city': address.city,
      'state': address.state,
      'stateCode': address.stateCode,
      'postalCode': address.postalCode,
      'country': address.country,
    };
    data['university'] = university;
    data['company'] = {
      'department': company.department,
      'name': company.name,
      'title': company.title,
      'address': {
        'address': company.address.address,
        'city': company.address.city,
        'state': company.address.state,
        'stateCode': company.address.stateCode,
        'postalCode': company.address.postalCode,
        'country': company.address.country,
      }
    };
    data['role'] = role;

    return data;
  }
}
