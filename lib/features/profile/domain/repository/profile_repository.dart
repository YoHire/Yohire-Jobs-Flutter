import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/profile/data/models/personal_details_model.dart';
import 'package:openbn/features/profile/domain/entity/applied_job_entity.dart';
import 'package:openbn/features/profile/domain/entity/saved_job_entity.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, void>> updatePersonalDetails(
      {required PersonalDetailsModel personalDetails});
  Future<Either<Failure, void>> updateSkills(
      {required List<SkillModel> skillIds});
  Future<Either<Failure, void>> updateJobPrefs(
      {required List<JobRoleModel> jobRoleIds});
  Future<Either<Failure, void>> updateLanguagesReadAndWrite(
      {required List<LanguageModel> languages});
  Future<Either<Failure, void>> updateLanguagesSpeak(
      {required List<LanguageModel> languages});
  Future<Either<Failure, void>> updateDocument(
      {required DocumentModel document,
      required File file,
      required ValueNotifier<double> progressTracker});
  Future<Either<Failure, List<SavedJobEntity>>> getSavedJobs();
  Future<Either<Failure, List<AppliedJobEntity>>> getAppliedJobs();
}
