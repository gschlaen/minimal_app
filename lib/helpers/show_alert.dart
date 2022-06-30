import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:minimal_app/themes/app_theme.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          MaterialButton(
            child: const Text('Ok', style: TextStyle(color: Colors.white)),
            color: AppTheme.primary,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok', style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}
