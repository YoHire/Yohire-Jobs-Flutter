import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/core/widgets/button.dart';
import 'package:openbn/core/widgets/theme_gap.dart';
import 'package:openbn/core/widgets/yohire_logo_widget.dart';
import 'package:openbn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:openbn/init_dependencies.dart';

class GoogleAuthPage extends StatelessWidget {
  const GoogleAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showSimpleSnackBar(
              position: SnackBarPosition.BOTTOM,
              isError: false,
              context: context,
              text: 'Authenticated as ${state.user.email}');
          if (state.user.isNewUser) {
            GoRouter.of(context).go('/otp_page');
          } else {
            showSimpleSnackBar(
                position: SnackBarPosition.BOTTOM,
                isError: false,
                context: context,
                text: 'Welcome back ${state.user.email}');
            GoRouter.of(context).go('/navigation_bar');
          }
        } else if (state is AuthError) {
          showSimpleSnackBar(
              position: SnackBarPosition.BOTTOM,
              isError: true,
              context: context,
              text: state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        tooltip: 'Help',
                        onPressed: () {},
                        icon: const Icon(Icons.support))),
                SizedBox(height: MediaQuery.of(context).size.height / 2 - 150),
                const YohireLogoWidget(),
                const Spacer(),
                Hero(
                  tag: 'nav-tag',
                  child: ThemedButton(
                    text: 'Continue as Guest',
                    onPressed: () {
                      GoRouter.of(context).go('/navigation_bar');
                    },
                    loading: false,
                  ),
                ),
                Text(
                  'or',
                  style: textTheme.bodySmall,
                ),
                const ThemeGap(5),
                Text(
                  'Sign in with',
                  style: textTheme.labelMedium,
                ),
                const ThemeGap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 0.4,
                      ),
                    )),
                    IconButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () async {
                          _signIn(context);
                        },
                        icon: Image.asset(
                          'assets/icon/google.webp',
                          width: 40,
                          height: 40,
                        )),
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 0.4,
                      ),
                    )),
                  ],
                ),
                const ThemeGap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.labelMedium,
                      children: [
                        const TextSpan(
                          text: 'By signing in you accept our ',
                        ),
                        TextSpan(
                          text: 'terms & conditions',
                          style:
                              const TextStyle(color: ThemeColors.primaryBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Get.to(() => const TermsAndConditions());
                            },
                        ),
                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'privacy policy',
                          style:
                              const TextStyle(color: ThemeColors.primaryBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Get.to(() => const PrivacyPolicyScreen());
                            },
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _logOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signIn(BuildContext ctx) {
    ctx.read<AuthBloc>().add(AuthInit());
  }

  _logOut() {
    FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
    GoogleSignIn googleSignIn = serviceLocator<GoogleSignIn>();

    firebaseAuth.signOut();
    googleSignIn.signOut();
  }
}
