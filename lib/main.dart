import 'package:concepta_challenge/service_locator.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';

void main() async {
  ServiceLocator.register();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: MainTheme.get(context),
        routes: <String, Widget Function(BuildContext)>{}..addEntries([
            ...routes,
          ]),
        initialRoute: Routes.home,
        themeMode: ThemeMode.dark,
      );
}
