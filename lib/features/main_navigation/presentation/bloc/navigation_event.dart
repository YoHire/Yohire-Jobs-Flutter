import 'package:openbn/features/main_navigation/presentation/bloc/navigation_bloc.dart';

class NavigationEvent {}

class NavigateTo extends NavigationEvent {
  final NavigationItem destination;
  NavigateTo(this.destination);
}