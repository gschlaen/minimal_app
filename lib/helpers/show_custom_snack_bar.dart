import 'package:flutter/material.dart';

showCustomSnackBar(context, String title) {
  var textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  var textAlign = TextAlign.center;
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: title.startsWith('Add')
        ? Text('The client was successfully created', style: textStyle, textAlign: textAlign)
        : title.startsWith('Edit')
            ? Text('The client was successfully modified', style: textStyle, textAlign: textAlign)
            : Text('The client was successfully deleted', style: textStyle, textAlign: textAlign),
  ));
}
