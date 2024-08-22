part of 'esbp.dart';

abstract class _ESbpPlatform extends PlatformInterface {
  /// Constructs a ESbpPlatform.
  _ESbpPlatform() : super(token: _token);

  static final Object _token = Object();

  static _ESbpPlatform _instance = _ESbpMethodChannel();

  /// The default instance of [ESbpPlatform] to use.
  ///
  /// Defaults to [ESbpMethodChannel].
  static _ESbpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ESbpPlatform] when
  /// they register themselves.
  static set instance(_ESbpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
