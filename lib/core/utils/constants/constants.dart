// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/shared_services/remote_config/remote_config_service.dart';

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
  static String fontName = 'Montserrat';
  static String defaultBoldFont = '$fontName-Bold';
  static String defaultRegularFont = '$fontName-Regular';
  static String defaultLightFont = '$fontName-Light';
}

class FirebaseRemoteConfigKeys {
  static const String api_url = 'api_url';
  static const String version = 'version';
  static const String version_apple = 'version_ios';
  static const String app_store_url = 'app_store_url';
  static const String play_store_url = 'play_store_url';
  static const String terms = 'terms_and_conditions';
  static const String privacy = 'privacy_policy';
  static const String sources = 'source';
  static const String instagram_influncers = 'instagram_influncers_list';
  static const String home_icon = 'home_logo';
  static const String home_icon_dark = 'home_logo_dark';
  static const String font = 'font';
}

class Status {
  static const String active = 'ACTIVE';
  static const String inactive = 'INACTIVE';
}

enum SnackBarPosition {
  BOTTOM,
  TOP,
  MIDDLE;
}

enum OtpStatus {
  AUTO('Phone Number Automatically Verified'),
  FAILED('Phone Number Verification Failed'),
  SUCCESS('Otp sent successfully');

  final String value;

  const OtpStatus(this.value);
}

enum LoaderType { jobLoader, normalLoader, profileLoader, fileLoader }

enum SocialMedia {
  LINKEDIN('LINKEDIN'),
  FACEBOOK('FACEBOOK'),
  INSTAGRAM('INSTAGRAM'),
  X('X'),
  GITHUB('GITHUB');

  final String value;

  const SocialMedia(this.value);
}

enum GenderType {
  Male('Male'),
  Female('Female'),
  Others('Others');

  final String value;

  const GenderType(this.value);
}

enum MaritialStatus {
  Married('Married'),
  Single('Single');

  final String value;

  const MaritialStatus(this.value);
}

enum ProfileSections {
  PersonalDetails('Personal Details'),
  AcademicDetails('Academic Details'),
  ExperienceDetails('Experience Details'),
  SkillsAndPrefrences('Skills And Prefrences'),
  Languages('Languages'),
  Documents('Documents');

  final String value;

  const ProfileSections(this.value);
}

enum ProfileStatus {
  Incomplete('Incomplete'),
  Completed('Completed'),
  Warning('Warning');

  final String value;

  const ProfileStatus(this.value);
}

abstract class ApiKeys {
  static const PLACES_IOS_KEY = "AIzaSyANJ35OUPR7qXtRCqlYxFD65Aihmw-DrA8";
  static const PLACES_ANDROID_KEY = "AIzaSyAQVhkbXrJfx83vjHqOrKMqODsLCILUyOE";

  static String places_api_key = "AIzaSyBCeQj1xv23zcjK1VfUKMdcJD8-k1upzuM";
}
