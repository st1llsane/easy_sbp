import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'esbp_platform_interface.dart';

/// An implementation of [ESbpPlatform] that uses method channels.
class ESbpMethodChannel extends ESbpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('easy_sbp');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
