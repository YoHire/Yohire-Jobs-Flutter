import 'dart:io';

import 'package:openbn/features/profile/data/models/personal_details_model.dart';

class PersonalDetailsEntity {
  final String username;
  final String surname;
  final String bio;
  final String address;
  final String gender;
  final String dateOfBirth;
  final String height;
  final String weight;
  File? profileImage;

  PersonalDetailsEntity(
      {required this.username,
      required this.surname,
      required this.bio,
      required this.address,
      required this.gender,
      this.profileImage,
      required this.dateOfBirth,
      required this.height,
      required this.weight});

  PersonalDetailsModel toData() {
    return PersonalDetailsModel(
        username: username,
        surname: surname,
        bio: bio,
        address: address,
        gender: gender,
        dateOfBirth: dateOfBirth,
        height: height,
        weight: weight,
        profileImage: profileImage);
  }
}
