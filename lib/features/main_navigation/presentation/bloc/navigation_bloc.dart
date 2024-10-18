import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';

enum NavigationItem { home, search, profile }

class NavigationBloc extends Bloc<NavigationEvent, NavigationItem> {
  NavigationBloc() : super(NavigationItem.home) {
    on<NavigateTo>((event, emit) => emit(event.destination));
  }
}