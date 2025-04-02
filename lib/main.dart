import 'package:digia_ui/digia_ui.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DUIApp(
      digiaAccessKey: '67d25ecc68d0b85479225509',
      flavorInfo: Debug(null),
      environment: 'development',
      baseUrl: 'https://app.digia.tech/api/v1',
      networkConfiguration:
          NetworkConfiguration(defaultHeaders: {}, timeout: 30),
    );
  }
}
