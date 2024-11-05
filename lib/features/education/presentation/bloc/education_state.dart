part of 'education_bloc.dart';

sealed class EducationState {}

final class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}
class EducationSaving extends EducationState {}

class EducationError extends EducationState {
  final String message;
  EducationError({required this.message});
}

class CategoriesLoaded extends EducationState {
  final List<CourseEntity> categories;
  final CourseEntity? selectedCategory;

  CategoriesLoaded({
    required this.categories,
    this.selectedCategory,
  });
}

class SubCategoriesLoaded extends EducationState {
  final List<CourseEntity> categories;
  final CourseEntity selectedCategory;
  final List<CourseEntity> subCategories;
  final CourseEntity? selectedSubCategory;

  SubCategoriesLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.subCategories,
    this.selectedSubCategory,
  });
}

class CoursesLoaded extends EducationState {
  final List<CourseEntity> categories;
  final CourseEntity selectedCategory;
  final bool showDrop;
  final List<CourseEntity>? subCategories;
  final CourseEntity? selectedSubCategory;
  final List<CourseEntity> courses;

  CoursesLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.showDrop,
    this.subCategories,
    this.selectedSubCategory,
    required this.courses,
  });
}

class EducationSavedState extends EducationState {}
