part of 'education_bloc.dart';

sealed class EducationEvent {}

class LoadCategories extends EducationEvent {
  final CourseEntity? previousCourse;

  LoadCategories({ this.previousCourse});
}

class CategorySelected extends EducationEvent {
  final CourseEntity category;
  CategorySelected(this.category);
}

class SubCategorySelected extends EducationEvent {
  final CourseEntity selectedCategory;
  final CourseEntity subCategory;
  SubCategorySelected(this.subCategory,this.selectedCategory);
}

class SaveSelectedCourse extends EducationEvent {
  final CourseEntity course;

  SaveSelectedCourse({required this.course});
}

class SaveEducation extends EducationEvent {
  final EducationEntity data;
  File? file;
  SaveEducation({required this.data, this.file});
}

