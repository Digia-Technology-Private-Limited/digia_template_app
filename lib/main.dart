import 'package:digia_ui/Utils/config_resolver.dart';
import 'package:digia_ui/Utils/util_functions.dart';
import 'package:digia_ui/core/page/dui_page.dart';
import 'package:digia_ui/core/pref/pref_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration
  await ConfigResolver.initialize('json/config.json');
  await PrefUtil.init();
  // await PrefUtil.clearStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
              color: toColor('text'),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      title: 'Flutter Demo',
      home: DUIPage(initData: ConfigResolver().getfirstPageData()),
    );
  }
}