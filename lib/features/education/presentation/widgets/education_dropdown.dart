import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/validators/text_validators.dart';
import 'package:openbn/core/widgets/custom_dropdown.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/education/domain/entity/course_entity.dart';
import 'package:openbn/features/education/presentation/bloc/education_bloc.dart';

class CourseDropdownWidget extends StatefulWidget {
  const CourseDropdownWidget({super.key});

  @override
  State<CourseDropdownWidget> createState() => _CourseDropdownWidgetState();
}

class _CourseDropdownWidgetState extends State<CourseDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationBloc, EducationState>(
      builder: (context, state) {
        if (state is EducationInitial) {
          context.read<EducationBloc>().add(LoadCategories());
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
              CustomDropdown<CourseEntity>(
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
                  CustomDropdown<CourseEntity>(
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
                  child: CustomDropdown<CourseEntity>(
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

  CourseEntity? _getSelectedCategory(EducationState state) {
    if (state is CategoriesLoaded) return state.selectedCategory;
    if (state is SubCategoriesLoaded) return state.selectedCategory;
    if (state is CoursesLoaded) return state.selectedCategory;
    return null;
  }

  CourseEntity? _getSelectedSubCategory(EducationState state) {
    if (state is SubCategoriesLoaded) return state.selectedSubCategory;
    if (state is CoursesLoaded) return state.selectedSubCategory;
    return null;
  }

  List<DropdownMenuItem<CourseEntity>> _getCategoryItems(EducationState state) {
    List<CourseEntity> categories = [];
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

  List<DropdownMenuItem<CourseEntity>> _getSubCategoryItems(
      EducationState state) {
    List<CourseEntity> subCategories = [];
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
