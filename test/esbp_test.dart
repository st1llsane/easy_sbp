import 'package:flutter_test/flutter_test.dart';
import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/esbp_platform_interface.dart';
import 'package:easy_sbp/esbp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockESbpPlatform with MockPlatformInterfaceMixin implements ESbpPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ESbpPlatform initialPlatform = ESbpPlatform.instance;

  test('$ESbpMethodChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<ESbpMethodChannel>());
  });

  test('getPlatformVersion', () async {
    ESbp easySbpPlugin = ESbp();
    MockESbpPlatform fakePlatform = MockESbpPlatform();
    ESbpPlatform.instance = fakePlatform;

    expect(await easySbpPlugin.getPlatformVersion(), '42');
  });
}
