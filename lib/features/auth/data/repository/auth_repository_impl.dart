import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openbn/core/error/faliure.dart';
import 'package:openbn/core/utils/functions/device_id.dart';
import 'package:openbn/features/auth/data/datasource/auth_datasource.dart';
import 'package:openbn/features/auth/data/models/auth_model.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';
import 'package:openbn/init_dependencies.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Faliure, AuthModel>> signIn() async {
    try {
      FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
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
          return Right(AuthModel(
              isExistingUser: data['data']['new'],
              email: userCredential.user!.email!));
        } else {
          return Left(
              Faliure(message: 'Cannot retrive data from google account'));
        }
      } else {
        return Left(Faliure(message: 'Cannot initiate Google Sign In'));
      }
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
