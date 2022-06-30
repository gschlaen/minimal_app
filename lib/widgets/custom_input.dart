import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController textController;

  const CustomInput({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    required this.textController,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
        autocorrect: false,
        obscureText: isObscureText,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: !isObscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
          ),
        ));
  }
}
