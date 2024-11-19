import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/features/home/domain/entities/job_entity.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:openbn/init_dependencies.dart';

class SaveButton extends StatefulWidget {
  final JobEntity job;

  const SaveButton({super.key, required this.job});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    final storage = serviceLocator.get<GetStorage>();
    return storage.read('isLogged') == true
        ? Padding(
            padding: const EdgeInsets.only(right: 2),
            child:
                context.read<HomeBloc>().savedJobsCache.contains(widget.job.id)
                    ? _buildColoredButton()
                    : context
                            .read<HomeBloc>()
                            .unSavedJobsCache
                            .contains(widget.job.id)
                        ? _buildOutlineddButton()
                        : widget.job.isSaved == true
                            ? _buildColoredButton()
                            : _buildOutlineddButton())
        : const SizedBox();
  }

  _buildColoredButton() {
    final colorTheme = Theme.of(context).colorScheme;
    return IconButton(
        onPressed: () {
          context.read<HomeBloc>().add(UnsaveJob(jobId: widget.job.id));
          setState(() {});
        },
        icon: Icon(
          Icons.bookmark_add,
          color: colorTheme.onSurface,
        ));
  }

  _buildOutlineddButton() {
    final colorTheme = Theme.of(context).colorScheme;
    return IconButton(
        onPressed: () {
          context.read<HomeBloc>().add(SaveJob(jobId: widget.job.id));
          setState(() {});
        },
        icon: Icon(
          Icons.bookmark_add_outlined,
          color: colorTheme.onSurface,
        ));
  }
}
