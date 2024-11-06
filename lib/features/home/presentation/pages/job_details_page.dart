import 'package:flutter/material.dart';
import 'package:openbn/core/widgets/app_bar.dart';
class JobDetailsScreen extends StatefulWidget {
  final String id;
  const JobDetailsScreen({super.key,required this.id});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar( context: context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            // leftHeadingWithSub(context: context, heading: heading, subHeading: subHeading)
          ],
        ),
      ),
    );
  }
}