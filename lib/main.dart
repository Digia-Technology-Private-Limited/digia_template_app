import 'package:digia_ui/Utils/digia_ui_sdk.dart';
import 'package:digia_ui/Utils/config_resolver.dart';
import 'package:digia_ui/Utils/util_functions.dart';
import 'package:digia_ui/core/page/dui_page.dart';
import 'package:digia_ui/core/pref/pref_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration
  await DigiaUiSDk.initialize('json/config.json');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digia Template App',
      home: DUIPage(initData: ConfigResolver().getfirstPageData()),
    );
  }
}