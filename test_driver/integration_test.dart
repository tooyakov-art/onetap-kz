import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final directory = Directory('build/app-store-screenshots');
      await directory.create(recursive: true);
      final screenshot = File('${directory.path}/$name.png').absolute;
      final simulatorUdid = Platform.environment['DEVICE_UDID'];

      if (Platform.isMacOS &&
          simulatorUdid != null &&
          simulatorUdid.isNotEmpty) {
        final result = await Process.run('xcrun', [
          'simctl',
          'io',
          simulatorUdid,
          'screenshot',
          '--type=png',
          screenshot.path,
        ]);
        if (result.exitCode != 0 || !await screenshot.exists()) {
          stderr.writeln(result.stderr);
          return false;
        }
      } else {
        await screenshot.writeAsBytes(bytes);
      }
      return true;
    },
  );
}
