import 'dart:async';

import 'package:flutter/services.dart';

class FlutterGroupData {
  static const MethodChannel _channel =
      const MethodChannel('flutter_group_data');


  /// 获取当前角标数量
  static Future<String> getGroupSharedBadge() async {
    final String version =
        await _channel.invokeMethod('getGroupSharedBadge');
    return version;
  }

  /// 设置角标数量
  static Future setGroupSharedBadge(String number) async {
    return await _channel.invokeMethod(
      'setGroupSharedBadge',
      number,
    );
  }

  /// 设置imei
  static Future setGroupSharedIMIE(String imei) async {
    return await _channel.invokeMethod(
      'setGroupSharedIMIE',
      imei,
    );
  }
}
