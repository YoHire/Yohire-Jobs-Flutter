part of 'education_bloc.dart';

sealed class EducationEvent {}

class LoadCategories extends EducationEvent {}

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

class LoadPreviousCourse extends EducationEvent{
  final CourseEntity course;

  LoadPreviousCourse({required this.course});
}
