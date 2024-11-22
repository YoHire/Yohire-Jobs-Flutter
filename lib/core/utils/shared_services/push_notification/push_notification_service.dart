import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/navigation/app_router.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/urls.dart';
import 'package:openbn/init_dependencies.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging =
      serviceLocator<FirebaseMessaging>();
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final GoRouter _router = serviceLocator<GoRouter>();
  Dio dio = serviceLocator<DioInterceptorHandler>().dio;
  final storage = serviceLocator<GetStorage>();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    // Request permission for iOS
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
        final payload = details.payload;
        if (payload != null) {
          final data = json.decode(payload);
          _handleNotificationNavigation(data);
        }
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: android.smallIcon,
            color: const Color(0xFF2196F3),
            // Customize notification style here
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    _handleNotificationNavigation(message.data);
  }

  void _handleInitialMessage(RemoteMessage message) {
    _handleNotificationNavigation(message.data);
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    // Handle different types of notifications and navigation
    final String? type = data['type'];
    final String? id = data['id'];

    switch (type) {
      case 'chat':
        _router.push('/chat/$id');
        break;
      case 'order':
        _router.push('/orders/$id');
        break;
      case 'profile':
        _router.push(AppRoutes.profile);
        break;
      default:
        _router.push('/notifications');
    }
  }

  Future<String> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken() ?? "";
      return token;
    } catch (e) {
      return "";
    }
  }

  Future<void> deleteFcmId() async {
    try {
      await dio.delete(
        '${URL.DELETE_FCMID}${storage.read('userId')}',
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
