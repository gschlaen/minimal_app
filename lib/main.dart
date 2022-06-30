import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/screens/screens.dart';
import 'package:minimal_app/themes/app_theme.dart';
import 'providers/providers.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ClientsProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SearchBarProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        'login': (_) => const LoginScreen(),
        'loading': (_) => const LoadingScreen(),
        'clients': (_) => const ClientsScreen(),
      },
      initialRoute: 'clients',
    );
  }
}
