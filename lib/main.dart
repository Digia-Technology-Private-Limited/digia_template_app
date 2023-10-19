import 'dart:async';
import 'dart:convert';

// import 'package:device_preview/device_preview.dart';
import 'package:digia_ui/Utils/config_resolver.dart';
import 'package:digia_ui/Utils/digia_ui_sdk.dart';
import 'package:digia_ui/Utils/util_functions.dart';
import 'package:digia_ui/core/page/dui_page.dart';
import 'package:digia_ui/core/page/dui_page_bloc.dart';
import 'package:digia_ui/core/page/dui_page_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration
  final response =
      await http.post(Uri.parse('https://app.digia.tech/hydrator/api/config/getAppConfig'),
          body: {
        "projectId": "64cbf9be022f05b9b12a2488"
      });
  final apiDataResponse = await jsonDecode(response.body as String);
  await DigiaUiSDk.initializeByJson(apiDataResponse['data']['response']);
  runApp(const MyApp());
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
        scaffoldBackgroundColor: toColor('light'),
        primaryColor: toColor('light'),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: toColor('primary'),
          ),
          color: toColor('light'),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
              color: toColor('text'),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      home: BlocProvider(
        create: (context) {
          final resolver = ConfigResolver();
          return DUIPageBloc(
              initData: resolver.getfirstPageData(), resolver: resolver)
            ..add(InitPageEvent());
        },
        child: const DUIPage(),
      ),
    );
  }
}
