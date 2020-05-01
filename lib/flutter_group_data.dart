import 'dart:async';

import 'package:flutter/services.dart';

class FlutterGroupData {
  static const MethodChannel _channel =
      const MethodChannel('flutter_group_data');

  static Future<String> groupShared(String key) async {
    final String version =
        await _channel.invokeMethod('getGroupShared', {"key": key});
    return version;
  }

  static Future<String> setGroupShared(String key, String value) async {
    final String version = await _channel.invokeMethod(
      'setGroupShared',
      {"key": key, "value": value},
    );
    return version;
  }

  static Future<String> getPushToken() async {
    final String version = await _channel.invokeMethod('getPushToken');
    return version;
  }

  static Future<String> getPushMessage() async {
    final String version = await _channel.invokeMethod('getPushMessage');
    return version;
  }
}
