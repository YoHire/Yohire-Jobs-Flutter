import 'package:openbn/core/utils/shared_services/models/recruiter/recruiter_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  JobModel(
      {required super.id,
      required super.recruiterId,
      required super.title,
      required super.hilights,
      required super.categoryId,
      required super.company,
      required super.country,
      required super.location,
      required super.interviewDate,
      required super.requirementCount,
      required super.isApplied,
      required super.isSaved,
      required super.date,
      required super.venue,
      required super.qualifications,
      required super.salary,
      required super.contarct,
      required super.status,
      required super.minAge,
      required super.maxAge,
      required super.minHeight,
      required super.maxHeight,
      required super.minWeight,
      required super.maxWeight,
      required super.createdAt,
      required super.updatedAt,
      required super.description,
      required super.userIds,
      required super.currency,
      required super.testQuestion,
      required super.expiryDate,
      super.recruiter,
      required super.skills});

  factory JobModel.fromJson(Map<String, dynamic> json, bool? isApplied) {
    return JobModel(
        id: json['id'] ?? '',
        recruiterId: json['recruiterId'] ?? '',
        title: json['title'] ?? '',
        categoryId: json['category'] ?? [],
        company: json['company'] ?? '',
        country: json['country'] ?? '',
        location: json['location'] ?? '',
        interviewDate: json['interviewDate'] ?? '',
        requirementCount: json['requirementCount'] ?? 0,
        date: json['date'] ?? '',
        venue: json['venue'] ?? '',
        qualifications: json['qualifications'] ?? [],
        hilights: json['highlightTags'] ?? [],
        salary: json['salary'] ?? '0',
        contarct: json['contarct'] ?? '',
        status: json['status'] ?? '',
        minAge: json['minAge'] ?? 0,
        maxAge: json['maxAge'] ?? 0,
        minHeight: json['minHeight'] ?? 0,
        maxHeight: json['maxHeight'] ?? 0,
        minWeight: json['minWeight'] ?? 0,
        maxWeight: json['maxWeight'] ?? 0,
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        description: json['description'] ?? '',
        userIds: defactorUserId(json['userJobs'] ?? []),
        currency: json['currency'] ?? '',
        testQuestion: json['testQuestion'] ?? [],
        expiryDate: json['expiryDate'] ?? '',
        recruiter: json['recruiter'] == null
            ? null
            : RecruiterModel.fromJson(json['recruiter']),
        skills: json['skills'] != null && (json['skills'] as List).isNotEmpty
            ? (json['skills'] as List)
                .map((e) => SkillModel.fromJson(e))
                .toList()
            : [],
        isApplied: isApplied??false,
        isSaved: json['isSaved']??false,
        );
  }

  static List<String> defactorUserId(List<dynamic> data) {
    List<String> temp = [];
    for (var element in data) {
      temp.add(element['userId']);
    }
    return temp;
  }


}
