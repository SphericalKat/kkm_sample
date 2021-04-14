import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

Future<Tuple2<String, String>> getDeviceId() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  const Uuid uuid = Uuid();
  String deviceId;
  String deviceName;

  if (Platform.isAndroid) {
    final build = await deviceInfoPlugin.androidInfo;
    deviceId = uuid.v5(Uuid.NAMESPACE_NIL, build.androidId).replaceAll('-', '');
    deviceName = build.model;
  } else if (Platform.isIOS) {
    final data = await deviceInfoPlugin.iosInfo;
    deviceId = uuid
        .v5(Uuid.NAMESPACE_NIL, data.identifierForVendor)
        .replaceAll('-', '');
    deviceName = data.name;
  } else {
    throw UnsupportedError('Only android and iOS are supported!');
  }

  return Tuple2(deviceId, deviceName);
}
