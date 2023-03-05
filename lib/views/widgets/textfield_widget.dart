import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData? prefixIconData;
  final bool password;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  //constructor
  const TextFieldWidget({super.key, required this.hintText, this.prefixIconData,
    this.password = false, required this.controller,this.validator});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) => widget.validator != null ? widget.validator!(text) : null, // validate field
      controller: widget.controller,
      obscureText: widget.password ? (isVisible? false : true) : false,
      style: const TextStyle(
        color: Global.orange,
        fontSize: 18.0,
      ),
      cursorColor: Global.orange,
      decoration: InputDecoration(
          labelText: widget.hintText,
          prefixIcon: Icon(
            widget.prefixIconData,
            size: 18,
            color: Global.orange,
          ),
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Global.orange,
            ),
          ),
          suffixIcon: widget.password? IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: isVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
            iconSize: 18,
            color: Global.orange,
          ) : null,
          labelStyle: const TextStyle(
            color: Global.orange,
          ),
          focusColor: Global.orange
      ),
    );
  }
}
