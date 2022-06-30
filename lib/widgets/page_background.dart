import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Widget child;
  final String assetName;
  const PageBackground({Key? key, required this.child, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(assetName),
          fit: BoxFit.cover,
        )),
        child: child);
  }
}
