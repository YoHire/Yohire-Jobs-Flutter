// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/circle/presentation/bloc/queue_bloc/queue_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class QueueEdit3 extends StatefulWidget {
  const QueueEdit3({super.key});

  @override
  State<QueueEdit3> createState() => _QueueEdit3State();
}

class _QueueEdit3State extends State<QueueEdit3> {
  SfRangeValues salaryRange = const SfRangeValues(2000.00, 4000.00);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const ThemeGap(10),
            leftHeadingWithSub(
                context: context,
                heading: 'Set Expected Monthly Salary',
                subHeading: 'Set the slider to your desired range'),
            const ThemeGap(5),
            SalaryRangeSelector(
              salaryRange: salaryRange,
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: FloatingActionButton(
              onPressed: () {
                context.read<QueueBloc>().pageController.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<QueueBloc>().add(SetSalaryRange(
                  startingSalary: salaryRange.start,
                  endingSalary: salaryRange.end));
              context.read<QueueBloc>().pageController.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SalaryRangeSelector extends StatefulWidget {
  SfRangeValues salaryRange;
  SalaryRangeSelector({super.key, required this.salaryRange});

  @override
  _SalaryRangeSelectorState createState() => _SalaryRangeSelectorState();
}

class _SalaryRangeSelectorState extends State<SalaryRangeSelector> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Currency : US Dollar (USD \$)',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 40),
          SfRangeSlider(
            min: 0.0,
            max: 14000.0,
            values: widget.salaryRange,
            interval: 3000,
            showTicks: true,
            showLabels: true,
            activeColor: Colors.green,
            inactiveColor: Colors.grey[300],
            numberFormat: NumberFormat('\$'),
            onChanged: (SfRangeValues newValues) {
              setState(() {
                widget.salaryRange = newValues;
                setSalaryRange(widget.salaryRange.start.round().toDouble(),
                    widget.salaryRange.end.round().toDouble());
              });
            },
          ),
          const SizedBox(height: 20),
          widget.salaryRange.end.round() == 14000
              ? Text(
                  'Selected Salary Range: \$${widget.salaryRange.start.round()} - \$${widget.salaryRange.end.round()}+',
                  style: textTheme.bodyMedium,
                )
              : Text(
                  'Selected Salary Range: \$${widget.salaryRange.start.round()} - \$${widget.salaryRange.end.round()}',
                  style: textTheme.bodyMedium,
                ),
        ],
      ),
    );
  }

  setSalaryRange(double start, double end) {
    widget.salaryRange = SfRangeValues(start, end);
  }
}
