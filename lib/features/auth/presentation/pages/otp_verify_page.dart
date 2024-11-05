import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/core/widgets/timer/bloc/timer_bloc.dart';
import 'package:openbn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:openbn/features/auth/presentation/widgets/otp_enter_widget.dart';
import 'package:openbn/init_dependencies.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  late TextEditingController phoneNumberController;
  late TextEditingController countryCodeController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    countryCodeController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is OtpSent) {
                _buildVerificationBottonSheet(context: context, state: state);
                showSimpleSnackBar(
                    position: SnackBarPosition.TOP,
                    isError: false,
                    context: context,
                    text: 'OTP sent successfully');
              } else if (state is OtpVerified) {
                context.read<AuthBloc>().add(CreateUser(
                    phone: state.phone,
                    idToken: state.idToken,
                    countryCode: state.countryCode));
              } else if (state is AuthError) {
                showSimpleSnackBar(
                    position: SnackBarPosition.BOTTOM,
                    isError: true,
                    context: context,
                    text: state.message);
              } else if (state is AuthSuccess) {
                showSimpleSnackBar(
                    position: SnackBarPosition.BOTTOM,
                    isError: false,
                    context: context,
                    text: 'OTP verified successfully');
                GoRouter.of(context).go('/username');
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'OTP',
                    style: textTheme.displayLarge,
                  ),
                  Text(
                    'VERIFICATION',
                    style: textTheme.displayLarge,
                  ),
                  const ThemeGap(20),
                  Text(
                    'We will send a one time password to this mobile number',
                    style: textTheme.labelMedium,
                  ),
                  const ThemeGap(60),
                  IntlPhoneField(
                    focusNode: FocusNode(),
                    controller: phoneNumberController,
                    disableLengthCheck: true,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: textTheme.labelMedium,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      countryCodeController.text = phone.countryCode;
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.center,
                        child: ThemedButton(
                          loading: state is AuthLoading,
                          text: 'Send OTP',
                          onPressed: () {
                            context.read<AuthBloc>().add(CheckPhoneNumber(
                                phoneNumber: phoneNumberController.text,
                                countryCode: countryCodeController.text));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildVerificationBottonSheet(
      {required BuildContext context, required OtpSent state}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return BlocProvider(
              create: (context) => serviceLocator<TimerBloc>(),
              child: OtpEnterWidget(
                state: state,
                scrollController: scrollController,
              ),
            );
          },
        );
      },
    );
  }
}
