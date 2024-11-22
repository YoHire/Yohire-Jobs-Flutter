import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/documents/document_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/language/language_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/core/utils/shared_services/models/user/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/features/profile/domain/entity/applied_job_entity.dart';
import 'package:openbn/features/profile/domain/entity/personal_details_entity.dart';
import 'package:openbn/features/profile/domain/entity/saved_job_entity.dart';
import 'package:openbn/features/profile/domain/usecase/get_applied_jobs_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/get_saved_jobs_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_document_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_jobpref_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_language_readwrite.dart';
import 'package:openbn/features/profile/domain/usecase/update_language_speak.dart';
import 'package:openbn/features/profile/domain/usecase/update_personal_details_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_skill_usecase.dart';
import 'package:openbn/init_dependencies.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdatePersonalDetailsUsecase _updatePersonalDetailsUsecase;
  final UpdateSkillUsecase _updateSkillUsecase;
  final UpdateJobprefUsecase _updateJobprefUsecase;
  final UpdateLanguageSpeakUsecase _updateLanguageSpeakUsecase;
  final UpdateLanguageReadwriteUsecase _updateLanguageReadwriteUsecase;
  final UpdateDocumentUsecase _updateDocumentUsecase;
  final GetSavedJobsUsecase _getSavedJobsUsecase;
  final GetAppliedJobsUsecase _getAppliedJobsUsecase;
  UserModel? userdata;
  ProfileBloc(
      {required UpdateSkillUsecase updateSkillUsecase,
      required UpdateJobprefUsecase updateJobprefUsecase,
      required UpdateLanguageSpeakUsecase updateLanguageSpeakUsecase,
      required UpdateLanguageReadwriteUsecase updateLanguageReadwriteUsecase,
      required UpdateDocumentUsecase updateDocumentUsecase,
      required GetSavedJobsUsecase getSavedJobsUsecase,
      required GetAppliedJobsUsecase getAppliedJobsUsecase,
      required UpdatePersonalDetailsUsecase updatePersonalDetailsUsecase})
      : _updatePersonalDetailsUsecase = updatePersonalDetailsUsecase,
        _updateSkillUsecase = updateSkillUsecase,
        _updateJobprefUsecase = updateJobprefUsecase,
        _updateLanguageSpeakUsecase = updateLanguageSpeakUsecase,
        _updateLanguageReadwriteUsecase = updateLanguageReadwriteUsecase,
        _updateDocumentUsecase = updateDocumentUsecase,
        _getSavedJobsUsecase = getSavedJobsUsecase,
        _getAppliedJobsUsecase = getAppliedJobsUsecase,
        super(ProfileInitial()) {
    on<UpdatePersonalDataEvent>(_handlePersonalDetailsUpdate);
    on<UpdateSkillEvent>(_handleSkillsUpdate);
    on<UpdateJobPrefs>(_handleJobPrefUpdate);
    on<UpdateLanguageReadwrite>(_handleLanguageReadwriteUpdate);
    on<UpdateLanguageSpeak>(_handleLanguageSpeakUpdate);
    on<UpdateDocument>(_handleUpdateDocument);
    on<LoadProfileEvent>(_handleLoadProfileEvent);
    on<GetSavedJobs>(_getSavedJobs);
    on<EmitBlocDocumentSuccess>(_emitDocumentUploadSuccess);
    on<GetAppliedJobs>(_getAppliedJobs);
  }

  _handlePersonalDetailsUpdate(
      UpdatePersonalDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());

    final result = await _updatePersonalDetailsUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update details'));
      },
      (success) async {
        emit(UpdateSuccess());
      },
    );
  }

  _handleSkillsUpdate(
      UpdateSkillEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());

    final result = await _updateSkillUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update skills'));
      },
      (success) async {
        emit(SkillUpdateSuccess());
      },
    );
  }

  _handleJobPrefUpdate(UpdateJobPrefs event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    final result = await _updateJobprefUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update Job prefrences'));
      },
      (success) async {
        emit(JobPrefUpdateSuccess());
      },
    );
  }

  _handleLanguageReadwriteUpdate(
      UpdateLanguageReadwrite event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    final result = await _updateLanguageReadwriteUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update Language'));
      },
      (success) async {
        emit(LanguageReadWriteUpdateSuccess());
      },
    );
  }

  _handleLanguageSpeakUpdate(
      UpdateLanguageSpeak event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    final result = await _updateLanguageSpeakUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update Language'));
      },
      (success) async {
        emit(LanguageSpeakUpdateSuccess());
      },
    );
  }

  _handleUpdateDocument(
      UpdateDocument event, Emitter<ProfileState> emit) async {
    emit(DocumentUploading());
    final result = await _updateDocumentUsecase(UpdateDocumentParams(
        model: event.data,
        progressTracker: event.progressTracker,
        file: event.file));

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update Document'));
      },
      (success) async {
        emit(DocumentUpdateSuccess());
      },
    );
  }

  _handleLoadProfileEvent(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    final ref = serviceLocator<UserStorageService>();
    await ref.updateUser();
    userdata = ref.getUser();
  }

  _getSavedJobs(GetSavedJobs event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getSavedJobsUsecase('');

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to get saved jobs'));
      },
      (success) async {
        if (success.isEmpty) {
          emit(SavedJobsEmpty());
        } else {
          emit(SavedJobsLoaded(jobs: success));
        }
      },
    );
  }

  _emitDocumentUploadSuccess(
      EmitBlocDocumentSuccess event, Emitter<ProfileState> emit) async {
    emit(DocumentUpdateSuccess());
  }

  _getAppliedJobs(GetAppliedJobs event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getAppliedJobsUsecase('');

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to get applied jobs'));
      },
      (success) async {
        if (success.isEmpty) {
          emit(AppliedJobsEmpty());
        } else {
          emit(AppliedJobsLoaded(jobs: success));
        }
      },
    );
  }
}
