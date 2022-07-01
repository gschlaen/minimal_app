import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const Positioned(child: Image(image: AssetImage('assets/login-vector-1.png')), right: 0, top: 0),
            const Positioned(child: Image(image: AssetImage('assets/login-vector-2.png')), left: 0, top: 380),
            const Positioned(child: Image(image: AssetImage('assets/login-vector-3.png')), bottom: 0),
            child,
          ],
        ));
  }
}
