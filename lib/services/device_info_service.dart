import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return {
        'platform': 'Android',
        'model': androidInfo.model,
        'sdkVersion': androidInfo.version.sdkInt,
        'brand': androidInfo.brand,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return {
        'platform': 'iOS',
        'name': iosInfo.name,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
      };
    } else {
      // Untuk platform lain seperti Windows/Linux
      return {
        'platform': Platform.operatingSystem,
        'version': Platform.operatingSystemVersion,
      };
    }
  }
}
