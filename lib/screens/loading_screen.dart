import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/screens/screens.dart';
import 'package:minimal_app/providers/providers.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Loading...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final authenticated = await authProvider.isLoggedIn();

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ClientsScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
