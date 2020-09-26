import 'dart:async';

import 'package:flutter/services.dart';

export './src/screens/ug_mobile_money/mobile_money_pay.dart';
export './src/screens/ug_mobile_money/core.dart';

class RaveFlutter {
  static const MethodChannel _channel =
      const MethodChannel('rave_flutter');

  // Gets a device ID setup by the device vendor
  static Future<String> get deviceId async => await _channel.invokeMethod('getDeviceId');

  // Encrypt JSON to 3DES base64
  static Future<String> getEncryptedData(String unEncryptedString, String encryptionKey)async{
    return await _channel.invokeMethod('getEncryptedData',[unEncryptedString,encryptionKey]);
  }

}

