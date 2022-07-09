import 'dart:developer';
import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
        final uniqueId = DateTime.now().microsecondsSinceEpoch;
        final File image = await File(
          'integration_test/screenshots/$uniqueId-$screenshotName.png',
        ).create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        return true;
      },
    );
  } catch (e) {
    log('Error on app_driver.dart: $e');
  }
}
