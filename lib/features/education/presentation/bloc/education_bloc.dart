import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/core/utils/shared_services/models/education/education_model.dart';
import 'package:openbn/features/education/domain/usecase/get_categories_usecase.dart';
import 'package:openbn/features/education/domain/usecase/get_course_usecase.dart';
import 'package:openbn/features/education/domain/usecase/get_subcategories_usecase.dart';
import 'package:openbn/features/education/domain/usecase/save_education_usecase.dart';
part 'education_event.dart';
part 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;
  final GetCoursesUseCase _getCoursesUseCase;
  final SaveEducationUsecase _saveEducationUseCase;
  List<CourseModel> fetchedCategories = [];
  List<CourseModel> fetchedSubCategories = [];
  CourseModel? selectedCourse;
  EducationBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetSubCategoriesUseCase getSubCategoriesUseCase,
    required GetCoursesUseCase getCoursesUseCase,
    required SaveEducationUsecase saveEducationUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getSubCategoriesUseCase = getSubCategoriesUseCase,
        _getCoursesUseCase = getCoursesUseCase,
        _saveEducationUseCase = saveEducationUseCase,
        super(EducationInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<CategorySelected>(_onCategorySelected);
    on<SubCategorySelected>(_onSubCategorySelected);
    on<SaveEducation>(_onSaveEducation);
    on<SaveSelectedCourse>(_saveSelectedCourse);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());
    try {
      final result = await _getCategoriesUseCase('');

      result.fold(
        (failure) {
          emit(EducationError(message: failure.message));
        },
        (success) {
          fetchedCategories = success;
          // log(event.previousCourse!.category);
          //   log(event.previousCourse!.course);
          //   log(event.previousCourse!.subCategory);
          //   log(event.previousCourse!.id);
          // log(':::::::::BASE:::::::::');
          // for(int i=0;i<fetchedCategories.length;i++){
          //   // if(fetchedCategories[i].category==event.previousCourse!.category){
          //   //   log('removed');
          //   //   fetchedCategories.removeAt(i);
              
          //   // }
          //   log(':::::::::START:::::::::');
          //   log(fetchedCategories[i].category);
          //   log(fetchedCategories[i].course);
          //   log(fetchedCategories[i].subCategory);
          //   log(fetchedCategories[i].id);
          //   log(':::::::::STOP:::::::::');
          // }
          emit(CategoriesLoaded(
            categories: fetchedCategories,
            selectedCategory: null,
          ));
          // if (event.previousCourse != null) {
          //   log('kerikknn');
          //   add(CategorySelected(event.previousCourse!));
          // }

        },
      );
    } catch (e) {
      emit(EducationError(message: e.toString()));
    }
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<EducationState> emit,
  ) async {
    try {
      emit(EducationLoading());

      if (['UG', 'PG'].contains(event.category.category)) {
        final result = await _getSubCategoriesUseCase(event.category.category);
        result.fold(
          (failure) {
            emit(EducationError(message: failure.message));
          },
          (success) {
            fetchedSubCategories = success;
            emit(SubCategoriesLoaded(
              categories: fetchedCategories,
              selectedCategory: event.category,
              subCategories: fetchedSubCategories,
              selectedSubCategory: null,
            ));
          },
        );
      } else {
        final result = await _getCoursesUseCase(GetCourseUsecaseParams(
            category: event.category.category, subCategory: ''));
        result.fold(
          (failure) {
            emit(EducationError(message: failure.message));
          },
          (success) {
            if (['BELOW 10th', 'SSLC', 'HIGHER SECONDARY']
                .contains(event.category.category)) {
              selectedCourse = success[0];
              emit(CoursesLoaded(
                showDrop: false,
                categories: fetchedCategories,
                selectedCategory: event.category,
                courses: success,
              ));
            } else {
              emit(CoursesLoaded(
                showDrop: true,
                categories: fetchedCategories,
                selectedCategory: event.category,
                courses: success,
              ));
            }
          },
        );
      }
    } catch (e) {
      emit(EducationError(message: e.toString()));
    }
  }

  Future<void> _onSubCategorySelected(
    SubCategorySelected event,
    Emitter<EducationState> emit,
  ) async {
    try {
      emit(EducationLoading());
      final result = await _getCoursesUseCase(
        GetCourseUsecaseParams(
            category: event.selectedCategory.category,
            subCategory: event.subCategory.subCategory),
      );

      result.fold(
        (failure) {
          emit(EducationError(message: failure.message));
        },
        (success) {
          if (['BELOW 10th', 'SSLC', 'HIGHER SECONDARY']
              .contains(event.selectedCategory.category)) {
            selectedCourse = success[0];
            emit(CoursesLoaded(
              categories: fetchedCategories,
              showDrop: false,
              selectedCategory: event.selectedCategory,
              subCategories: fetchedSubCategories,
              selectedSubCategory: event.subCategory,
              courses: success,
            ));
          } else {
            emit(CoursesLoaded(
              categories: fetchedCategories,
              showDrop: true,
              selectedCategory: event.selectedCategory,
              subCategories: fetchedSubCategories,
              selectedSubCategory: event.subCategory,
              courses: success,
            ));
          }
        },
      );
    } catch (e) {
      emit(EducationError(message: e.toString()));
    }
  }

  Future<void> _onSaveEducation(
    SaveEducation event,
    Emitter<EducationState> emit,
  ) async {
    try {
      emit(EducationSaving());

      final result = await _saveEducationUseCase(EducationUseCaseParms(
          educationModel: event.data, certificate: event.file));

      result.fold(
        (failure) {
          emit(EducationError(message: failure.message));
        },
        (success) {
          emit(EducationSavedState());
        },
      );
    } catch (e) {
      emit(EducationError(message: e.toString()));
    }
  }

  Future<void> _saveSelectedCourse(
    SaveSelectedCourse event,
    Emitter<EducationState> emit,
  ) async {
    try {
      selectedCourse = event.course;
    } catch (e) {
      emit(EducationError(message: e.toString()));
    }
  }
}
