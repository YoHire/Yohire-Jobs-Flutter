import 'dart:developer';

import 'package:flutter/services.dart';

  Future<String> getDeviceId() async {
    const platform = MethodChannel('com.yohiresoftwares.uniqueid');
    try {
      final String? uniqueId = await platform.invokeMethod('getUniqueId');
      return uniqueId!;
    } catch (e) {
      log('Failed to get device id: $e');
      throw Exception(e);
    }
  }
