// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/widgets/yohire_logo_widget.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:openbn/features/splash/presentation/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoggedIn) {
          context.read<HomeBloc>().add(HomeInitEvent());
          GoRouter.of(context).go('/navigation-bar');
        } else if (state is SplashLoggedOut) {
          GoRouter.of(context).go('/prefrences');
        }
      },
      child: Scaffold(
        body: FadeTransition(
          opacity: _animation,
          child: const Center(
            child: YohireLogoWidget(showTagLine: true,),
          ),
        ),
      ),
    );
  }
}
