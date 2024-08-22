part of 'esbp.dart';

/// An implementation of [ESbpPlatform] that uses method channels.
class _ESbpMethodChannel extends _ESbpPlatform {
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
