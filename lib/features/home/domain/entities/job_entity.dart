import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';

class JobEntity {
  final String id;
  final String recruiterId;
  final String title;
  final List<dynamic> categoryId;
  final String company;
  final String country;
  final String location;
  final String interviewDate;
  final int requirementCount;
  final String date;
  final String venue;
  final String salary;
  final List<dynamic> qualifications;
  final List<dynamic> hilights;
  final List<SkillModel> skills;
  final String contarct;
  final String status;
  final int minAge;
  final int maxAge;
  final int minHeight;
  final int maxHeight;
  final int minWeight;
  final int maxWeight;
  final String createdAt;
  final String updatedAt;
  final String description;
  final List<String> userIds;
  final String expiryDate;
  final RecruiterModel? recruiter;
  final bool isApplied;
  final bool isSaved;
  String? source;
  String currency;
  List<dynamic> testQuestion;
  JobEntity(
      {required this.id,
      required this.recruiterId,
      this.recruiter,
      required this.currency,
      required this.isApplied,
      required this.description,
      required this.userIds,
      required this.expiryDate,
      required this.title,
      required this.hilights,
      required this.categoryId,
      required this.company,
      required this.country,
      required this.location,
      required this.interviewDate,
      required this.requirementCount,
      required this.date,
      required this.venue,
      required this.qualifications,
      required this.salary,
      required this.contarct,
      required this.status,
      required this.minAge,
      required this.maxAge,
      required this.minHeight,
      required this.maxHeight,
      required this.minWeight,
      required this.maxWeight,
      required this.createdAt,
      required this.updatedAt,
      this.source,
      required this.isSaved,
      required this.skills,
      required this.testQuestion});
}
