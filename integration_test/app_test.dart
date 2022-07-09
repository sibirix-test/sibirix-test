import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fwitter/main.dart' as app;
import 'package:integration_test/integration_test.dart';

//  flutter drive --driver=integration_test/app_driver.dart --target=integration_test/app_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();

  testWidgets('take screenshot', (tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.onError!(details);
    };

    app.main();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));

    await tester.pumpAndSettle();

    await binding.takeScreenshot('screenshot');
  });
}
