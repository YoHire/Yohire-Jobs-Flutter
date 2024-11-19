import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/experience/workexperience_model.dart';
import 'package:openbn/features/experience/domain/usecases/delete_experience_usecase.dart';
import 'package:openbn/features/experience/domain/usecases/save_experience_usecase.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final SaveExperienceUsecase _saveExperienceUsecase;
  final DeleteExperienceUsecase _deleteExperienceUsecase;
  ExperienceBloc(
      {required SaveExperienceUsecase saveExperienceUsecase,
      required DeleteExperienceUsecase deleteExperienceUsecase})
      : _saveExperienceUsecase = saveExperienceUsecase,
        _deleteExperienceUsecase = deleteExperienceUsecase,
        super(ExperienceInitial()) {
    on<SaveExperience>(_onSaveExperience);
    on<DeleteExperience>(_deleteExperience);
  }
  Future<void> _onSaveExperience(
    SaveExperience event,
    Emitter<ExperienceState> emit,
  ) async {
    try {
      emit(ExperienceSaving());

      if (event.data.designation == null) {
        emit(ExperienceError(
            message: 'You mush select a jobrole from the dropdown'));
        return;
      }

      final result = await _saveExperienceUsecase(ExperienceUseCaseParms(
          experienceModel: event.data, certificate: event.file));

      result.fold(
        (failure) {
          emit(ExperienceError(message: failure.message));
        },
        (success) {
          emit(ExperienceSaved());
        },
      );
    } catch (e) {
      emit(ExperienceError(message: e.toString()));
    }
  }

  Future<void> _deleteExperience(
    DeleteExperience event,
    Emitter<ExperienceState> emit,
  ) async {
    try {
      final result = await _deleteExperienceUsecase(event.id);

      result.fold(
        (failure) {
          emit(ExperienceError(message: failure.message));
        },
        (success) {
          emit(ExperienceSaved());
        },
      );
    } catch (e) {
      emit(ExperienceError(message: e.toString()));
    }
  }
}
