import 'package:flutter/material.dart';

import 'package:minimal_app/themes/app_theme.dart';

class BlackButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;

  const BlackButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 19),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: const StadiumBorder(),
        disabledColor: Colors.grey,
        elevation: 5,
        color: AppTheme.primary,
        minWidth: double.infinity,
        child: Container(
          padding: padding,
          child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.white, letterSpacing: 0.5)),
        ),
        onPressed: onPressed);
  }
}
