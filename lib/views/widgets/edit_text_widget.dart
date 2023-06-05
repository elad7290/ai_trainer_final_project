import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  const EditText({super.key, required this.label, required this.placeHoler, required this.isPassword});
  final String label;
  final String placeHoler;
  final bool isPassword;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool isObscurePassword = true;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
        bottom: 30,
      ),
      child: TextField(
        obscureText: widget.isPassword? isObscurePassword: false,
        decoration: InputDecoration(
            suffixIcon: widget.isPassword?
            IconButton(
                onPressed: (){
                  setState(() {
                    isObscurePassword = ! isObscurePassword;

                  });
                },
                icon: isObscurePassword? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
            ): null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: widget.label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.placeHoler,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )
        ),
      ),
    );
  }
}


