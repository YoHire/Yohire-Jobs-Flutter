import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/shared_services/functions/device_id.dart';
import 'package:openbn/core/utils/shared_services/user/models/user_model.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/features/auth/data/datasource/auth_datasource.dart';
import 'package:openbn/features/auth/data/models/auth_model.dart';
import 'package:openbn/features/auth/domain/entity/auth_entity.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';
import 'package:openbn/init_dependencies.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, AuthModel>> signIn() async {
    try {
      FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
      UserStorageService userLocalStorage =
          serviceLocator<UserStorageService>();
      GoogleSignIn googleSignIn = serviceLocator<GoogleSignIn>();
      FirebaseMessaging firebaseMessaging = serviceLocator<FirebaseMessaging>();
      GetStorage localStorage = serviceLocator<GetStorage>();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          Map<String, dynamic> body = {
            "email": userCredential.user!.email,
            "fcmId": await firebaseMessaging.getToken(),
            "idToken": await userCredential.user!.getIdToken(),
            "deviceId": await getDeviceId(),
          };
          final data = await datasource.signIn(body: body);
          if (data['data']['new'] == false) {
            localStorage.write("accessToken", data['data']["accessToken"]);
            localStorage.write("refreshToken", data['data']["refreshToken"]);
            localStorage.write("isLogged", true);
            localStorage.write("userId", data['data']["user"]["id"]);
            localStorage.write("email", data['data']["user"]["email"]);
          }
          await userLocalStorage
              .saveUser(UserModel.fromJson(data['data']['user']));
          return Right(AuthModel(
              isNewUser: data['data']['new'],
              email: userCredential.user!.email!));
        } else {
          return Left(
              Failure(message: 'Cannot retrive data from google account'));
        }
      } else {
        return Left(Failure(message: 'Cannot initiate Google Sign In'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPhone({required String phone}) async {
    try {
      final data = await datasource.checkPhoneNumber(phone: phone);
      return Right(data['data']);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp(
      {required String phoneWithCountryCode}) async {
    try {
      FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
      Completer<String> completer = Completer<String>();
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneWithCountryCode,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
      );
      return Right(await completer.future);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(
      {required String verificationId, required String otp}) async {
    try {
      FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await firebaseAuth.signInWithCredential(credential);
      String? token = await firebaseAuth.currentUser!.getIdToken();
      return Right(token ?? '');
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> verifyPhone(
      {required String idToken,
      required String phone,
      required String countryCode}) async {
    try {
      UserStorageService userLocalStorage =
          serviceLocator<UserStorageService>();
      GetStorage localStorage = serviceLocator<GetStorage>();
      GoogleSignIn googleSignIn = serviceLocator<GoogleSignIn>();
      FirebaseMessaging firebaseMessaging = serviceLocator<FirebaseMessaging>();

      Map<String, dynamic> body = {
        "phone": phone,
        "email": googleSignIn.currentUser!.email,
        "countryCode": countryCode,
        "fcmId": await firebaseMessaging.getToken(),
        "deviceId": await getDeviceId(),
        "idToken": idToken
      };

      final data = await datasource.verifyPhone(body: body);
      log(data.toString());
      localStorage.write("accessToken", data['data']["accessToken"]);
      localStorage.write("refreshToken", data['data']["refreshToken"]);
      localStorage.write("isLogged", true);
      localStorage.write("userId", data['data']["user"]["id"]);
      localStorage.write("email", data['data']["user"]["email"]);

      await userLocalStorage.saveUser(UserModel.fromJson(data['data']['user']));
      return Right(
          AuthEntity(email: data['data']["user"]["email"], isNewUser: false));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
