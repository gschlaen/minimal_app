import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/helpers/show_alert.dart';
import 'package:minimal_app/providers/providers.dart';
import 'package:minimal_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      assetName: 'assets/background-login.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(height: 145),
              Image(image: AssetImage('assets/logo.png'), width: 282),
              SizedBox(height: 59),
              Text('LOG IN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2.5)),
              SizedBox(height: 34),
              _LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        children: [
          CustomInput(
            hintText: 'Email',
            textController: emailController,
          ),
          const SizedBox(height: 20),
          CustomInput(
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            textController: passwordController,
          ),
          const SizedBox(height: 50),
          BlackButton(
            text: 'LOG IN',
            onPressed: authProvider.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginSucces = await authProvider.login(emailController.text.trim(), passwordController.text.trim());
                    print(emailController.text.trim() + '' + passwordController.text.trim());
                    if (loginSucces) {
                      Navigator.pushReplacementNamed(context, 'clients');
                    } else {
                      showAlert(context, 'Login error', 'Please check your credentials');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
