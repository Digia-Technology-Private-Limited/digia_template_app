import 'package:digia_database_integration/digia_database_integration.dart';
import 'package:digia_template_app/firebase_options.dart';
import 'package:digia_ui/digia_ui.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseIntegrate = await DigiaFirebaseIntegration.init(
      DefaultFirebaseOptions.currentPlatform);

  await DigiaUIClient.init(
    accessKey: '67ddc2b66203de1fed5b9a7b',
    flavorInfo: Debug(null),
    environment: 'development',
    baseUrl: 'https://dev.digia.tech/api/v1',
    networkConfiguration: NetworkConfiguration(
      defaultHeaders: {},
      timeout: 30,
    ),
    databaseIntegration: firebaseIntegrate,
  );
  DUIFactory().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digia UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DUIFactory().createPage('homepage', {}),
    );
  }
}
