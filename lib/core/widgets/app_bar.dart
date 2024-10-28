import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar customAppBar({required String route, required BuildContext context,String? title}) {
  return AppBar(
    title: Text(title??''),
    leading: IconButton(
      onPressed: (){

        // GoRouter.of(context).go(route);
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_circle_left),
    ),
  );
}
