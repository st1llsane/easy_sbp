import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'easy_sbp_platform_interface.dart';

/// An implementation of [EasySbpPlatform] that uses method channels.
class MethodChannelEasySbp extends EasySbpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('easy_sbp');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
