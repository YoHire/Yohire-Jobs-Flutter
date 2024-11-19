import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/utils/shared_services/models/course/course_model.dart';
import 'package:openbn/core/validators/validators.dart';
import 'package:openbn/core/widgets/custom_dropdown.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/education/presentation/bloc/education_bloc.dart';

class CourseDropdownWidget extends StatefulWidget {
  final CourseModel? data;
  const CourseDropdownWidget({super.key, this.data});

  @override
  State<CourseDropdownWidget> createState() => _CourseDropdownWidgetState();
}

class _CourseDropdownWidgetState extends State<CourseDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationBloc, EducationState>(
      builder: (context, state) {
        if (state is EducationInitial) {
          context.read<EducationBloc>().add(LoadCategories(previousCourse: widget.data != null
                  ? CourseModel(
                      id: widget.data!.id,
                      course: widget.data!.course,
                      category: widget.data!.category,
                      subCategory: widget.data!.subCategory):null));
          return const SizedBox.shrink();
        }

        if (state is EducationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Category Dropdown
            if (state is CategoriesLoaded ||
                state is SubCategoriesLoaded ||
                state is CoursesLoaded)
              CustomDropdown<CourseModel>(
                  validator: TextValidators.eduLevelValidator,
                  value: _getSelectedCategory(state),
                  items: _getCategoryItems(state),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<EducationBloc>()
                          .add(CategorySelected(value));
                    }
                  },
                  hint: 'Select Education Level'),
            const ThemeGap(10),

            // Sub Category Dropdown
            if (state is SubCategoriesLoaded ||
                (state is CoursesLoaded && state.subCategories != null))
              Column(
                children: [
                  CustomDropdown<CourseModel>(
                      validator: TextValidators.courseValidator,
                      items: _getSubCategoryItems(state),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<EducationBloc>().add(SubCategorySelected(
                              value, _getSelectedCategory(state)!));
                        }
                      },
                      value: _getSelectedSubCategory(state),
                      hint: 'Select Course'),
                ],
              ),
            const ThemeGap(10),

            // Course Dropdown
            if (state is CoursesLoaded)
              Visibility(
                  visible: state.showDrop,
                  child: CustomDropdown<CourseModel>(
                      validator: TextValidators.specializationValidator,
                      items: state.courses.map((course) {
                        return DropdownMenuItem(
                          value: course,
                          child: Text(course.course),
                        );
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<EducationBloc>()
                            .add(SaveSelectedCourse(course: value!));
                      },
                      hint: 'Select Specialization')),
          ],
        );
      },
    );
  }

  CourseModel? _getSelectedCategory(EducationState state) {
    if (state is CategoriesLoaded) return state.selectedCategory;
    if (state is SubCategoriesLoaded) return state.selectedCategory;
    if (state is CoursesLoaded) return state.selectedCategory;
    return null;
  }

  CourseModel? _getSelectedSubCategory(EducationState state) {
    if (state is SubCategoriesLoaded) return state.selectedSubCategory;
    if (state is CoursesLoaded) return state.selectedSubCategory;
    return null;
  }

  List<DropdownMenuItem<CourseModel>> _getCategoryItems(EducationState state) {
    List<CourseModel> categories = [];
    if (state is CategoriesLoaded) categories = state.categories;
    if (state is SubCategoriesLoaded) categories = state.categories;
    if (state is CoursesLoaded) categories = state.categories;

    return categories.map((category) {
      return DropdownMenuItem(
        value: category,
        child: Text(category.category),
      );
    }).toList();
  }

  List<DropdownMenuItem<CourseModel>> _getSubCategoryItems(
      EducationState state) {
    List<CourseModel> subCategories = [];
    if (state is SubCategoriesLoaded) subCategories = state.subCategories;
    if (state is CoursesLoaded && state.subCategories != null) {
      subCategories = state.subCategories!;
    }

    return subCategories.map((subCategory) {
      return DropdownMenuItem(
        value: subCategory,
        child: Text(subCategory.subCategory),
      );
    }).toList();
  }
}
