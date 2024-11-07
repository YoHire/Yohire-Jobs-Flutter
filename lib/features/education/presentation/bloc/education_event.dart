part of 'education_bloc.dart';

sealed class EducationEvent {}

class LoadCategories extends EducationEvent {
  final CourseModel? previousCourse;

  LoadCategories({ this.previousCourse});
}

class CategorySelected extends EducationEvent {
  final CourseModel category;
  CategorySelected(this.category);
}

class SubCategorySelected extends EducationEvent {
  final CourseModel selectedCategory;
  final CourseModel subCategory;
  SubCategorySelected(this.subCategory,this.selectedCategory);
}

class SaveSelectedCourse extends EducationEvent {
  final CourseModel course;

  SaveSelectedCourse({required this.course});
}

class SaveEducation extends EducationEvent {
  final EducationModel data;
  File? file;
  SaveEducation({required this.data, this.file});
}

