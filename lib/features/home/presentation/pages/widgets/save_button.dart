import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/init_dependencies.dart';

class SaveButton extends StatelessWidget {
  final JobEntity job;

  const SaveButton({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final storage = serviceLocator.get<GetStorage>();
    return storage.read('isLogged') == true
        ? Padding(
            padding: const EdgeInsets.only(right: 2),
            child:
                // profileInfoController.savedJobs.any((data) => data.id == job.id)
                1 > 2
                    ? IconButton(
                        onPressed: () {
                          // profileInfoController.unSaveJob(jobId: job.id);
                        },
                        icon: Icon(
                          Icons.bookmark_add,
                          color: colorTheme.onSurface,
                        ))
                    : IconButton(
                        onPressed: () {
                          // controller.saveJob(jobId: job.id);
                        },
                        icon: Icon(
                          Icons.bookmark_add_outlined,
                          color: colorTheme.onSurface,
                        )),
          )
        : const SizedBox();
  }
}
