// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/remote_config_service.dart';

class ThemeColors {
  static const primaryBlue = Color(0xFF194092);
  static const black = Color(0xff424242);
  static const darkBlue = Color(0xFF0B4A89);
  static const fontColor = Color(0xff424242);
  static const fontGrey = Color(0xff424242);
  static const borderColor = Color(0xFFEDEEEF);
  static const white = Color.fromARGB(255, 255, 255, 255);
}

class FileAnnotations {
  static const String EDUCATION_CERTIFICATE = 'education_certificate';
  static const String EXPERIENCE_CERTIFICATE = 'experience_certificate';
  static const String PROFILE_PICTURE = 'profile';
  static const String PASSPORT_FILE = 'passport';
  static const String PASSPORT_FILE_BACK = 'passport_back';
  static const String DRIVING_LICENSE = 'driving_license';
  static const String DRIVING_LICENSE_BACK = 'driving_license_back';
  static const String INTL_DRIVING_LICENSE = 'international_driving_license';
  static const String INTL_DRIVING_LICENSE_BACK =
      'international_driving_license_back';
  static const String RESUME = 'resume';
  static const String COVER_LETTER = 'cover_letter';
}

class FontFamily {
  static final remoteConfig = FirebaseRemoteConfigService();
  static String fontName = 'OpenSans';
  static String OPEN_SANS_BOLD = '$fontName-Bold';
  static String OPEN_SANS_REGULAR = '$fontName-Regular';
  static String OPEN_SANS_LIGHT = '$fontName-Light';
}

class FirebaseRemoteConfigKeys {
  static const String api_url = 'api_url';
  static const String version = 'version';
  static const String version_apple = 'version_ios';
  static const String app_store_url = 'app_store_url';
  static const String play_store_url = 'play_store_url';
  static const String pay1 = 'pay1';
  static const String pay2 = 'pay2';
  static const String pay3 = 'pay3';
  static const String pay_scheme_1 = 'pay_scheme_1';
  static const String pay_scheme_2 = 'pay_scheme_2';
  static const String pay_scheme_3 = 'pay_scheme_3';
  static const String razor_pay_key = 'razor_pay_key';
  static const String terms = 'terms_and_conditions';
  static const String privacy = 'privacy_policy';
  static const String sources = 'source';
  static const String instagram_influncers = 'instagram_influncers_list';
  static const String home_icon = 'home_logo';
  static const String font = 'font';
}

class Status {
  static const String active = 'ACTIVE';
  static const String inactive = 'INACTIVE';
}

class EducationLevel {
  static List<String> level = [
    'BELOW 10th',
    'SSLC',
    'HIGHER SECONDARY',
    'UNDER GRADUATE (UG)',
    'POST GRADUATE (PG)',
    'ITI',
    'DIPLOMA',
    'Phd'
  ];
  static List<String> UG = [
    'B.A',
    'Bachelor',
    'B.A (Hons.)',
    'BBA',
    'BBA (Hons.)',
    'BBM',
    'BBM (Hons.)',
    'B.Com',
    'B.Com (Hons.)',
    'B.Design',
    'B.E',
    'B.Tech',
    'B.ED',
    'B.pharma'
  ];
}

enum InvitationStatus {
  ACCEPTED('ACCEPTED'),
  REJECTED('DECLINED'),
  PENDING('PENDING');

  final String value;

  const InvitationStatus(this.value);
}

enum LoaderType { jobLoader, normalLoader, profileLoader }

enum SocialMedia {
  LINKEDIN('LINKEDIN'),
  FACEBOOK('FACEBOOK'),
  INSTAGRAM('INSTAGRAM'),
  X('X'),
  GITHUB('GITHUB');

  final String value;

  const SocialMedia(this.value);
}

class ClientIds {
  static const String GIT_HUB = "Ov23liOsBF33r18uoxV5";
  static const String LINKEDIN = "864c4ff7uuc0ms";
  static const String INSTAGRAM = "Ov23liOsBF33r18uoxV5";
  static const String X = "MTBWelFVbFBnaHpSdTZ1Z1NjRG86MTpjaQ";
  static const String FACEBOOK = "Ov23liOsBF33r18uoxV5";
}

class ClientSecrets {
  static const String GIT_HUB = "d412c3917de136be0756184b3e037c810e2fb3aa";
}
