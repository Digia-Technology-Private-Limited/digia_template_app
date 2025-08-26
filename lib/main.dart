import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final digiaUI = await DigiaUI.initialize(
    DigiaUIOptions(
      accessKey: const String.fromEnvironment('projectId'),
      flavor: Flavor.debug(environment: Environment.production)
    ),
  );

runApp(
    DigiaUIApp(
      digiaUI: digiaUI,
      builder: (context) => MaterialApp(
        home: DUIFactory().createInitialPage(),
      ),
    ),
  );
}
