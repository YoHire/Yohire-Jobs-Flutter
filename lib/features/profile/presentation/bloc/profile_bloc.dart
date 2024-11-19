import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/core/utils/shared_services/models/skill/skill_model.dart';
import 'package:openbn/features/profile/domain/entity/personal_details_entity.dart';
import 'package:openbn/features/profile/domain/usecase/update_jobpref_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_personal_details_usecase.dart';
import 'package:openbn/features/profile/domain/usecase/update_skill_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdatePersonalDetailsUsecase _updatePersonalDetailsUsecase;
  final UpdateSkillUsecase _updateSkillUsecase;
  final UpdateJobprefUsecase _updateJobprefUsecase;
  ProfileBloc(
      {required UpdateSkillUsecase updateSkillUsecase,
      required UpdateJobprefUsecase updateJobprefUsecase,
      required UpdatePersonalDetailsUsecase updatePersonalDetailsUsecase})
      : _updatePersonalDetailsUsecase = updatePersonalDetailsUsecase,
        _updateSkillUsecase = updateSkillUsecase,
        _updateJobprefUsecase = updateJobprefUsecase,
        super(ProfileInitial()) {
    on<UpdatePersonalDataEvent>(_handlePersonalDetailsUpdate);
    on<UpdateSkillEvent>(_handleSkillsUpdate);
    on<UpdateJobPrefs>(_handleJobPrefUpdate);
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
     log('keri');
    final result = await _updateJobprefUsecase(event.data);

    result.fold(
      (failure) {
        emit(UpdateError(message: 'Failed to update jon prefrences'));
      },
      (success) async {
        log('success');
        emit(JobPrefUpdateSuccess());
      },
    );
  }
}
