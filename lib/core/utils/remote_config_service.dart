import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';


class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._(); // NEW

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> initialize() async {
    await setConfigSettings();
    // await setDefaults();
    await fetchAndActivate();
}

  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) =>_remoteConfig.getBool(key);
  int getInt(String key) =>_remoteConfig.getInt(key);
  double getDouble(String key) =>_remoteConfig.getDouble(key);

  Future<void> setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 30),
      minimumFetchInterval: const Duration(seconds: 3),
    ),
  );


Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      log('The config has been updated.');
    } else {
      log('The config is not updated..');
    }
  }
}