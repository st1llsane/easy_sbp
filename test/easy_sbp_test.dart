import 'package:flutter_test/flutter_test.dart';
import 'package:easy_sbp/easy_sbp.dart';
import 'package:easy_sbp/easy_sbp_platform_interface.dart';
import 'package:easy_sbp/easy_sbp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEasySbpPlatform
    with MockPlatformInterfaceMixin
    implements EasySbpPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EasySbpPlatform initialPlatform = EasySbpPlatform.instance;

  test('$MethodChannelEasySbp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEasySbp>());
  });

  test('getPlatformVersion', () async {
    EasySbp easySbpPlugin = EasySbp();
    MockEasySbpPlatform fakePlatform = MockEasySbpPlatform();
    EasySbpPlatform.instance = fakePlatform;

    expect(await easySbpPlugin.getPlatformVersion(), '42');
  });
}
