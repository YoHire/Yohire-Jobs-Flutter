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
  final List<CourseModel> categories;
  final CourseModel? selectedCategory;

  CategoriesLoaded({
    required this.categories,
    this.selectedCategory,
  });
}

class SubCategoriesLoaded extends EducationState {
  final List<CourseModel> categories;
  final CourseModel selectedCategory;
  final List<CourseModel> subCategories;
  final CourseModel? selectedSubCategory;

  SubCategoriesLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.subCategories,
    this.selectedSubCategory,
  });
}

class CoursesLoaded extends EducationState {
  final List<CourseModel> categories;
  final CourseModel selectedCategory;
  final bool showDrop;
  final List<CourseModel>? subCategories;
  final CourseModel? selectedSubCategory;
  final List<CourseModel> courses;

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
