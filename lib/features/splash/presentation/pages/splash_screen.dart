// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_bloc.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_event.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoggedIn) {
          context.read<HomeBloc>().add(HomeInitEvent());
          GoRouter.of(context).go('/navigation_bar');
        } else if (state is SplashLoggedOut) {
          context.read<PrefrenceBloc>().add(PrefrenceFetch(industry: 'none'));
          GoRouter.of(context).go('/prefrences');
        }
      },
      child: Scaffold(
        body: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: '',
                  width: 250,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/icon/logo-main.png',
                      width: 250,
                    );
                  },
                  placeholder: (BuildContext ctx, String str) {
                    return Image.asset(
                      'assets/icon/logo-main.png',
                      width: 250,
                    );
                  },
                ),
                Text(
                  'Your gateway to global opportunities',
                  style: textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
