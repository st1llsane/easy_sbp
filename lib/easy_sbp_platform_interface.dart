import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'easy_sbp_method_channel.dart';

abstract class EasySbpPlatform extends PlatformInterface {
  /// Constructs a EasySbpPlatform.
  EasySbpPlatform() : super(token: _token);

  static final Object _token = Object();

  static EasySbpPlatform _instance = MethodChannelEasySbp();

  /// The default instance of [EasySbpPlatform] to use.
  ///
  /// Defaults to [MethodChannelEasySbp].
  static EasySbpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EasySbpPlatform] when
  /// they register themselves.
  static set instance(EasySbpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
