import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:digia_ui/Utils/config_resolver.dart';
import 'package:digia_ui/Utils/digia_ui_sdk.dart';
import 'package:digia_ui/core/page/dui_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration
  final response =
      await http.get(Uri.parse('https://demo1139397.mockable.io/bytes'));
  await DigiaUiSDk.initialize(response.body);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digia Template App',
      home: DevicePreview(
        enabled: defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.fuchsia,
        builder: (context) => DUIPage(
          initData: ConfigResolver().getfirstPageData(),
        ),
      ),
    );
  }
}
