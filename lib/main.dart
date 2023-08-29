import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:air_quality_index/themes/default_themes.dart';
import 'package:air_quality_index/utilities/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: DefaultThemes().light,
      dark: DefaultThemes().dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (lightTheme, darkTheme) => MaterialApp.router(
        title: 'Air Quality Index',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: defaultRouter,
      ),
    );
  }
}
