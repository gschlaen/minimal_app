import 'package:flutter/material.dart';

class ClientsBackground extends StatelessWidget {
  final Widget child;
  const ClientsBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const Positioned(child: Image(image: AssetImage('assets/clients-vector-1.png')), left: 0, top: 0),
            const Positioned(child: Image(image: AssetImage('assets/clients-vector-2.png')), right: 0, top: 249),
            const Positioned(child: Image(image: AssetImage('assets/clients-vector-3.png')), left: 0, top: 677),
            const Positioned(child: Image(image: AssetImage('assets/clients-vector-4.png')), right: 0, bottom: 0),
            child,
          ],
        ));
  }
}
