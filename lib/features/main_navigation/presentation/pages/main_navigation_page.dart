import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openbn/features/home/presentation/pages/home_page.dart';
import '../../../circle/presentation/pages/circle_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NavigationBloc, NavigationItem>(
      builder: (context, currentItem) {
        return Scaffold(
          body: _buildBody(currentItem),
          bottomNavigationBar: FlashyTabBar(
              backgroundColor: colorTheme.surface,
              selectedIndex: NavigationItem.values.indexOf(currentItem),
              onItemSelected: (index) => _onItemTapped(context, index),
              items: [
                FlashyTabBarItem(
                  title: Text('Home', style: textTheme.bodyMedium),
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: colorTheme.onSurface,
                  ),
                ),
                FlashyTabBarItem(
                  title: Text('Circle', style: textTheme.bodyMedium),
                  icon: Image.asset(
                    'assets/icon/circle.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                FlashyTabBarItem(
                  title: Text('Profile', style: textTheme.bodyMedium),
                  icon: Icon(
                    Icons.account_circle,
                    color: colorTheme.onSurface,
                    size: 30,
                  ),
                )
              ]),
        );
      },
    );
  }

  Widget _buildBody(NavigationItem item) {
    switch (item) {
      case NavigationItem.home:
        return const HomePage();
      case NavigationItem.search:
        return const CirclePage();
      case NavigationItem.profile:
        return const ProfilePage();
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    BlocProvider.of<NavigationBloc>(context).add(
      NavigateTo(NavigationItem.values[index]),
    );
  }
}
