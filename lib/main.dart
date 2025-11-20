import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:microempresa/router/app_router.dart';
import 'package:microempresa/themes/app_theme.dart';
import 'package:microempresa/data/repositories/producto_repository.dart';
import 'package:microempresa/presentation/providers/producto_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductoProvider(
            repository: ProductoRepository(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Microempresas App',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter, // Usa GoRouter
      ),
    );
  }
}
