import 'dart:async';
import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:digia_template_app/util/platform_util.dart';
import 'package:digia_ui/Utils/config_resolver.dart';
import 'package:digia_ui/Utils/digia_ui_sdk.dart';
import 'package:digia_ui/core/page/dui_page.dart';
import 'package:digia_ui/core/page/dui_page_bloc.dart';
import 'package:digia_ui/core/page/dui_page_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

FutureOr<void> main() async {
  // print(const String.fromEnvironment('projectId'));
  final platformUtil = PlatformUtil();
  var projectId = platformUtil.getProjectId();
  print(projectId);
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration
  final response = await http.post(
    Uri.parse('https://app.digia.tech/hydrator/api/config/getAppConfig'),
    body: {
      "projectId": projectId,
    },
  );
  final apiDataResponse = await jsonDecode(response.body);
  await DigiaUiSDk.initializeByJson(
    apiDataResponse['data']['response'],
  );
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
      title: 'Digia Template App',
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
      home: BlocProvider(
        create: (context) {
          final resolver = ConfigResolver();
          return DUIPageBloc(
            initData: resolver.getfirstPageData(),
            resolver: resolver,
          )..add(
              InitPageEvent(),
            );
        },
        child: const DUIPage(),
      ),
    );
  }
}
