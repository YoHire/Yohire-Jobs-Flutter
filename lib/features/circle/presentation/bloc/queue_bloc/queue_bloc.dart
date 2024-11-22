import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/country/country_service.dart';
import 'package:openbn/core/utils/shared_services/models/country/country_model.dart';
import 'package:openbn/core/utils/shared_services/models/job_role/job_role_model.dart';
import 'package:openbn/features/circle/domain/usecases/create_queue_usecase.dart';
part 'queue_event.dart';
part 'queue_state.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  JobRoleModel? jobRole;
  List<CountryModel> countriesId = [];
  List<CountryModel> allCountries = [];
  double salaryStart = 0.0;
  String bio = '';
  double salaryEnd = 0.0;
  PageController pageController = PageController();
  final CreateQueueUsecase _createQueueUsecase;
  QueueBloc({required CreateQueueUsecase createQueueUsecase})
      : _createQueueUsecase = createQueueUsecase,
        super(QueueInitial()) {
    on<QueueInitEvent>(_handleQueueInitEvent);
    on<SelectJobRole>(_handleSelectJobRole);
    on<SelectCountry>(_handleSelectCountry);
    on<SelectAllCountry>(_handleSelectAllCountry);
    on<DeSelectAllCountry>(_handleDeSelectAllCountry);
    on<SetSalaryRange>(_handleSetSalary);
    on<JoinQueue>(_joinQueue);
  }

  Future<void> _handleQueueInitEvent(
    QueueInitEvent event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      allCountries.addAll(await CountryService().allCountries());
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _handleSelectJobRole(
    SelectJobRole event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      jobRole = event.jobRole;
      emit(QueueLoaded(
          jobRole: jobRole!,
          countries: countriesId,
          salaryEnd: salaryEnd,
          salaryStart: salaryStart));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _handleSelectCountry(
    SelectCountry event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      for (int i = 0; i < countriesId.length; i++) {
        if (countriesId[i].id == event.country.id) {
          countriesId.removeAt(i);
          emit(QueueLoaded(
              jobRole: jobRole!,
              countries: countriesId,
              salaryEnd: salaryEnd,
              salaryStart: salaryStart));
          return;
        }
      }
      countriesId.add(event.country);
      emit(QueueLoaded(
          jobRole: jobRole!,
          countries: countriesId,
          salaryEnd: salaryEnd,
          salaryStart: salaryStart));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _handleSelectAllCountry(
    SelectAllCountry event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      countriesId.clear();
      countriesId.addAll(allCountries);
      emit(QueueLoaded(
          jobRole: jobRole!,
          countries: countriesId,
          salaryEnd: salaryEnd,
          salaryStart: salaryStart));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _handleDeSelectAllCountry(
    DeSelectAllCountry event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      countriesId.clear();
      emit(QueueLoaded(
          jobRole: jobRole!,
          countries: countriesId,
          salaryEnd: salaryEnd,
          salaryStart: salaryStart));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _handleSetSalary(
    SetSalaryRange event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueLoading());
    try {
      salaryStart = event.startingSalary;
      salaryEnd = event.endingSalary;
      emit(QueueLoaded(
          jobRole: jobRole!,
          countries: countriesId,
          salaryEnd: salaryEnd,
          salaryStart: salaryStart));
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }

  Future<void> _joinQueue(
    JoinQueue event,
    Emitter<QueueState> emit,
  ) async {
    emit(QueueJoining());
    try {
      if (event.bio.isEmpty) {
        emit(QueueError(error: 'Bio Cannot be empty'));
        return;
      }
      final result = await _createQueueUsecase(CreateQueueParams(
          jobRole: jobRole!,
          countries: countriesId,
          salaryStart: salaryStart,
          salaryEnd: salaryEnd,
          bio: event.bio));

      result.fold(
        (failure) {
          emit(QueueError(error: failure.message));
        },
        (success) {
          emit(QueueJoined());
        },
      );
    } catch (e) {
      emit(QueueError(error: e.toString()));
    }
  }
}
