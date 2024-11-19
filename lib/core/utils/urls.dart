// ignore_for_file: non_constant_identifier_names
import 'package:openbn/core/utils/shared_services/remote_config/remote_config_service.dart';

final remoteConfig = FirebaseRemoteConfigService();
// const String baseUrl = "http://192.168.29.18:3000/api/v2";
const String baseUrl = "http://192.168.29.221:3000/api/v2";
// const String baseUrl = "https://www.20heads.com/api/v1";
// const String baseUrl = "http://localhost:3000/api/v1";
// String baseUrl = "https://api.yohire.in/api/v1";
// String baseUrl = remoteConfig.getString(FirebaseRemoteConfigKeys.api_url);
// const String baseUrl = "https://api.yohire.in/api/v1";
// const String baseUrl = "https://f1b7-150-129-100-250.ngrok-free.pp/api/v1";

abstract class URL {
  static String AUTH = "$baseUrl/auth";
  static String LOGIN = "$AUTH/user-login";
  static String REFRESH = "$baseUrl/auth/refresh-token";
  static String PREFRENCE_JOBS = "$baseUrl/users/prefrence-jobs/";
  static String ALL_JOBS = "$baseUrl/users/jobs/";
  static String MORE_JOBS = "$baseUrl/users/more-jobs/";
  static String SEARCH_JOBS = "$baseUrl/recruiter/search-jobs/";
  static String CATEGORIES = "$baseUrl/recruiter/categories/:ACTIVE";
  static String SEARCH_CATEGORIES = "$baseUrl/recruiter/categories/";
  static String SEARCH_COUNTRIES = "$baseUrl/users/countries/";
  static String ALL_COUNTRIES = "$baseUrl/users/countries";
  static String SEARCH_JOB_ROLE = "$baseUrl/recruiter/job-roles/";
  static String GET_CATEGORY_BY_ID = "$baseUrl/users/categories/";
  static String UPDATE_CATEGORY = "$baseUrl/users/update-categories/";
  static String SEARCH_SKILL = "$baseUrl/recruiter/skills/search-skills/";
  static String GET_SKILL_BY_ID = "$baseUrl/users/skills/";
  static String UPDATE_SKILL = "$baseUrl/users/update-skills/";
  static String UPDATE_PROFILE = "$baseUrl/users/update-user/";
  static String UPDATE_USERNAME = "$baseUrl/users/username";
  static String USER = "$baseUrl/users/user/";
  static String EDUCATION = "$baseUrl/users/education/";
  static String DELETE_EDUCATION = "$baseUrl/users/delete-education/";
  static String GET_EDUCATION = "$baseUrl/users/education-id/";
  static String UPDATE_EDUCATION = "$baseUrl/users/update-education/";
  static String ADD_EDUCATION = "$baseUrl/users/add-education";
  static String EXPERIENCE = "$baseUrl/users/experience/";
  static String DELETE_EXPERIENCE = "$baseUrl/users/delete-experience/";
  static String GET_EXPERIENCE = "$baseUrl/users/experience-id/";
  static String UPDATE_EXPERIENCE = "$baseUrl/users/update-experience/";
  static String ADD_EXPERIENCE = "$baseUrl/users/add-experience/";
  static String SAVE_JOB = "$baseUrl/users/save";
  static String UNSAVE_JOB = "$baseUrl/users/unsave";
  static String GET_SAVED_JOB = "$baseUrl/users/savedJobs/";
  static String APPLIED_JOBS = "$baseUrl/users/applied/";
  static String FILTER_JOBS = "$baseUrl/users/filter";
  static String LANGUAGES = "$baseUrl/recruiter/languages/";
  static String GET_JOB_BY_ID = "$baseUrl/users/jobs-fetch/";
  static String GET_JOB_BY_ID_LOGOUT = "$baseUrl/users/job/";
  static String APPLY = "$baseUrl/users/apply";
  static String UPDATE_PERSONAL_INFO = "$baseUrl/users/personal-info-update";
  static String NOTIFICATION = "$baseUrl/users/notifications/";
  static String SEEN_NOTIFICATION = "$baseUrl/users/seen-notification/";
  static String UPLOAD_RESUME = "$baseUrl/users/resume-upload/";
  static String DELETE_FCMID = "$baseUrl/users/fcmId/";
  static String DUPLICATE_JOB_APPLICATION = "$baseUrl/users/check-duplicate/";
  static String DELETE_ACCOUNT = "$baseUrl/users/delete/";
  static String RANDOM_CATEGORIES = "$baseUrl/recruiter/random-categories";
  static String RANDOM_JOB_ROLES = "$baseUrl/recruiter/random-job-roles/";
  static String GUEST_SIGNUP = "$baseUrl/users/guest-signup";
  static String DELETE_NOTIFICATION = "$baseUrl/users/delete-notifications";
  static String GET_SUB_COURSES = "$baseUrl/recruiter/sub-courses/";
  static String GET_COURSES = "$baseUrl/recruiter/get-courses/";
  static String CHECK_PHONE = "$baseUrl/users/check-phone/";
  static String VERIFY_PHONE = "$baseUrl/auth/verify-phone/";
  static String SOCIAL_LINKS = "$baseUrl/users/create-social-link";
  static String QUALIFICATIONS_CATEGORY =
      "$baseUrl/users/qualifications-category";
  static String QUALIFICATIONS_SUBCATEGORY =
      "$baseUrl/users/qualifications-subcategory/";
  static String QUALIFICATIONS_COURSE = "$baseUrl/users/qualifications-course/";

  //Yohire Circle API's
  static String CREATE_QUEUE = "$baseUrl/circle/create-queue";
  static String GET_ALL_QUEUES = "$baseUrl/circle/get-queue";
  static String GET_ALL_INVITATIONS = "$baseUrl/circle/invitations/";
  static String GET_QUEUE_BY_ID = "$baseUrl/circle/queue/";
  static String EDIT_QUEUE = "$baseUrl/circle/edit-queue";
  static String DELETE_QUEUE = "$baseUrl/circle/delete-queue";
  static String REJECT_INVITATION = "$baseUrl/circle/reject/";
  static String ACCEPT_INVITATION = "$baseUrl/circle/accept";
}
