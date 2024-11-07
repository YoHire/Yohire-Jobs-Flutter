import 'package:openbn/core/utils/constants/constants.dart';

class RecruiterModel {
  final String id;
  final String bio;
  final String name;
  final String email;
  final String address;
  final String github;
  final String facebook;
  final String linkedIn;
  final String x;
  final String instagram;
  final int jobs;
  final String createdAt;
  final String updatedAt;
  final int invites;
  final String image;
  final List<String> images;

  RecruiterModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.email,
      required this.facebook,
      required this.github,
      required this.linkedIn,
      required this.instagram,
      required this.x,
      required this.address,
      required this.bio,
      required this.createdAt,
      required this.updatedAt,
      required this.jobs,
      required this.invites,
      required this.images});

  factory RecruiterModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    String github = '';
    String facebook = '';
    String linkedIn = '';
    String x = '';
    String instagram = '';
    if (json['socialLinks'] != null) {
      for (var link in json['socialLinks']) {
        if (link['platform'] == SocialMedia.GITHUB.value) {
          github = link['url'].toString();
        } else if (link['platform'] == SocialMedia.LINKEDIN.value) {
          linkedIn = link['url'].toString();
        } else if (link['platform'] == SocialMedia.FACEBOOK.value) {
          facebook = link['url'].toString();
        } else if (link['platform'] == SocialMedia.INSTAGRAM.value) {
          instagram = link['url'].toString();
        } else if (link['platform'] == SocialMedia.X.value) {
          x = link['url'].toString();
        }
      }
    }

    if (json['companyImages'] != null) {
      for (var image in json['companyImages']) {
        images.add(image['url'].toString());
      }
    }
    return RecruiterModel(
        id: json['id'],
        image: json['image'] ?? '',
        name: json['ra'],
        email: json['email'],
        github: github,
        facebook: facebook,
        linkedIn: linkedIn,
        instagram: instagram,
        x: x,
        bio: json['bio'] ?? '',
        address: json['address'] ?? '',
        createdAt: json['createdAt'],
        updatedAt: json['lastActiveAt'] ?? '',
        jobs: json['jobs'] == null ? 0 : json['jobs'].length,
        invites: json['invitedJob'] == null ? 0 : json['invitedJob'].length,
        images: images,);
  }
}
