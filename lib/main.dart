import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FutureOr<void> main() async {
  var projectId = "65a4e1b85cc29694890b42e8";
  WidgetsFlutterBinding.ensureInitialized();
  await DigiaUIClient.initializeFromNetwork(accessKey: projectId);
  runApp(
    DevicePreview(
      enabled: defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.fuchsia,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bytes',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blueAccent,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blueAccent,
          ),
          color: Colors.blueAccent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      home: Builder(builder: (context) {
        final initialRouteData =
            DigiaUIClient.getConfigResolver().getfirstPageData();

        return DUIPage(pageUid: initialRouteData.identifier);
      }),
    );
  }
}
