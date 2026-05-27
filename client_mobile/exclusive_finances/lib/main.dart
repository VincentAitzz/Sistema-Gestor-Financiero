import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/main_layout.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const ExclusiveApp(),
    ),
  );
}

class ExclusiveApp extends StatelessWidget {
  const ExclusiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el cambio de tema desde el Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Exclusive Finances',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainLayout(),
    );
  }
}