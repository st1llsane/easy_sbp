import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'esbp_method_channel.dart';

abstract class ESbpPlatform extends PlatformInterface {
  /// Constructs a ESbpPlatform.
  ESbpPlatform() : super(token: _token);

  static final Object _token = Object();

  static ESbpPlatform _instance = ESbpMethodChannel();

  /// The default instance of [ESbpPlatform] to use.
  ///
  /// Defaults to [ESbpMethodChannel].
  static ESbpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ESbpPlatform] when
  /// they register themselves.
  static set instance(ESbpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
