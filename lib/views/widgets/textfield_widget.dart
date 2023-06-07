import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData? prefixIconData;
  final bool password;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  //constructor
  const TextFieldWidget({super.key, required this.hintText, this.prefixIconData,
    this.password = false, required this.controller,this.validator, required this.textInputType});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) => widget.validator != null ? widget.validator!(text) : null, // validate field
      controller: widget.controller,
      obscureText: widget.password ? (isVisible? false : true) : false,
      style: const TextStyle(
        color: AppColors.orange,
        fontSize: 18.0,
      ),
      cursorColor: AppColors.orange,
      decoration: InputDecoration(
          labelText: widget.hintText,
          prefixIcon: Icon(
            widget.prefixIconData,
            size: 18,
            color: AppColors.orange,
          ),
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.orange,
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
            color: AppColors.orange,
          ) : null,
          labelStyle: const TextStyle(
            color: AppColors.orange,
          ),
          focusColor: AppColors.orange
      ),
    );
  }
}
