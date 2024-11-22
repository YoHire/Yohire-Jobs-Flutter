import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openbn/core/navigation/app_router.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/shared_services/push_notification/push_notification_service.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';
import 'package:openbn/init_dependencies.dart';

Future<void> logoutUser(BuildContext context) async {
  final notificationService = serviceLocator<NotificationService>();
  final hiveData = serviceLocator<UserStorageService>();
  final storage = serviceLocator<GetStorage>();
  final auth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  await storage.erase();
  await hiveData.deleteUser();
  await auth.signOut();
  await googleSignIn.signOut();
  GoRouter.of(context).go(AppRoutes.preferences);
  
  showSimpleSnackBar(context: context, text: 'Logged Out Successfully', position: SnackBarPosition.BOTTOM, isError: false);
  notificationService.deleteFcmId();
}
