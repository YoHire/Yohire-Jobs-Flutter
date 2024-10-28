import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/validators/text_validators.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/main_heading_sub_heading.dart';
import 'package:openbn/core/widgets/text_field.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/features/username/presentation/bloc/username_bloc.dart';

class UsernameEnterPage extends StatelessWidget {
  const UsernameEnterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UsernameEnterView();
  }
}

class UsernameEnterView extends StatefulWidget {
  const UsernameEnterView({super.key});

  @override
  State<UsernameEnterView> createState() => _UsernameEnterViewState();
}

class _UsernameEnterViewState extends State<UsernameEnterView> {
  late TextEditingController _usernameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsernameBloc, UsernameState>(
      listener: (context, state) {
        if (state is UsernameError) {
          showSimpleSnackBar(
              context: context,
              text: state.errorMessage,
              position: SnackBarPosition.BOTTOM,
              isError: true);
        } else if (state is UsernameSaved) {
          GoRouter.of(context).go('/getting-jobs-loader/navigation-bar');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const ThemeGap(30),
                    leftHeadingWithSub(
                      context: context,
                      heading: 'Set a Username',
                      subHeading: 'Try to provide your firstname',
                    ),
                    CustomTextField(
                      hint: 'username',
                      controller: _usernameController,
                      prefixIcon: const Icon(Icons.account_box_rounded),
                      validator: (value) =>TextValidators.nameValidator(value),
                    ),
                    Lottie.asset('assets/lottie/username.json', repeat: false),
                    BlocBuilder<UsernameBloc, UsernameState>(
                      builder: (context, state) {
                        return ThemedButton(
                          text: 'Save',
                          loading: state is UsernameLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<UsernameBloc>().add(
                                    SaveUserName(
                                        username: _usernameController.text.trim()),
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
