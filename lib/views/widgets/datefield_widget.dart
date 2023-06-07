import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/globals.dart';
import '../../shared/validators.dart';

class DateFieldWidget extends StatefulWidget {
  final IconData? prefixIconData;
  final TextEditingController controller;
  final String? Function(String?)? validator;



  //constructor
  const DateFieldWidget({super.key, this.prefixIconData,
     required this.controller,this.validator});

  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  DateTime dateTime = DateTime.now();

  void _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime.now()
    ).then((value){
      setState(() {
        dateTime = value!;
        widget.controller.text = DateFormat('dd-MM-yyyy').format(dateTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _showDatePicker,
      keyboardType: TextInputType.datetime,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text)=>Validators.validateDate(text), // validate field
      controller: widget.controller,
      obscureText: false,
      style: const TextStyle(
        color: AppColors.orange,
        fontSize: 18.0,
      ),
      cursorColor: AppColors.orange,
      decoration: InputDecoration(
          labelText: "Birth Date",
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
          suffixIcon: null,
          labelStyle: const TextStyle(
            color: AppColors.orange,
          ),
          focusColor: AppColors.orange
      ),
    );
  }
}
