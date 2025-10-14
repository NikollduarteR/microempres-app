import 'package:flutter/material.dart';
import 'package:microempresa/router/app_router.dart';
import 'package:microempresa/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Microempresas App',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter, // Usa GoRouter
    );
  }
}
