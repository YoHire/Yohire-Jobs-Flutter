import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/core/theme/app_text_styles.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/core/widgets/timer/bloc/timer_bloc.dart';
import 'package:openbn/core/widgets/timer/timer_page.dart';
import 'package:openbn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpEnterWidget extends StatefulWidget {
  final OtpSent state;

  const OtpEnterWidget(
      {super.key, required this.state});

  @override
  _OtpEnterWidgetState createState() => _OtpEnterWidgetState();
}

class _OtpEnterWidgetState extends State<OtpEnterWidget> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    context.read<TimerBloc>().add(TimerStarted());
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VERIFY OTP',
                style: textTheme.displayLarge,
              ),
              const ThemeGap(10),
              Row(
                children: [
                  Text(
                    'Enter the OTP sent to ${widget.state.countryCode} ${widget.state.number}',
                    style: textTheme.labelMedium,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(color: ThemeColors.primaryBlue),
                      ))
                ],
              ),
              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  if (state is TimerFinished) {
                    return TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(CheckPhoneNumber(
                              phoneNumber: widget.state.number,
                              countryCode: widget.state.countryCode));
                          Navigator.of(context).pop();
                        },
                        style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(0))),
                        child: Text(
                          'Resend OTP',
                          style: textTheme.bodyMedium,
                        ));
                  } else {
                    return const CustomTimer(
                      duration: 60,
                    );
                  }
                },
              ),
              const Spacer(),
              _buildCodeEnterWidget(context),
              const Spacer(),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ThemedButton(
                      loading: state is AuthLoading,
                      text: 'Verify',
                      onPressed: () => _verifyOtp(context,
                          widget.state.countryCode, widget.state.number),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeEnterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          length: 6,
          animationType: AnimationType.fade,
          textStyle: Theme.of(context).textTheme.labelLarge,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeColor: Colors.grey,
            inactiveColor: Colors.grey,
            selectedColor: Colors.grey,
            activeFillColor: Colors.transparent,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            borderWidth: 1.0,
          ),
          cursorColor: ThemeColors.white,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: _otpController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
        const ThemeGap(5),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthError) {
              return Text(
                'Invalid OTP',
                style: MyTextStyle.bodySmallRed,
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  void _verifyOtp(BuildContext context, String countryCode, String phone) {
    final otp = _otpController.text;
    if (otp.length == 6) {
      context.read<AuthBloc>().add(
            VerifyOtp(
              countryCode: countryCode,
              phone: phone,
              otp: otp,
              verificationId: widget.state.verificationId,
            ),
          );
    } else {
      showSimpleSnackBar(
          position: SnackBarPosition.BOTTOM,
          context: context,
          text: 'Please enter a valid 6-digit OTP',
          isError: true);
    }
  }
}
