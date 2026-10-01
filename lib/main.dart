import 'package:flutter/material.dart';

import 'common/navigation/whimsey_app_controller.dart';
import 'common/theme/whimsey_theme.dart';
import 'features/shell/app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = WhimseyAppController();
  await controller.restoreTheme();
  runApp(WhimseyApp(controller: controller));
}

class WhimseyApp extends StatelessWidget {
  const WhimseyApp({required this.controller, super.key});

  final WhimseyAppController controller;

  @override
  Widget build(BuildContext context) {
    return WhimseyScope(
      controller: controller,
      child: ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Whimsey Technologies',
            debugShowCheckedModeBanner: false,
            theme: buildWhimseyTheme(brightness: Brightness.light),
            darkTheme: buildWhimseyTheme(brightness: Brightness.dark),
            themeMode: controller.themeMode,
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
