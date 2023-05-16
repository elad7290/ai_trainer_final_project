import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/globals.dart';

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
  bool isVisible = false;
  DateTime dateTime = DateTime.now();

  String? validator(){
    var date = DateTime.tryParse(widget.controller.text);
    if(date == null){
      return "enter a valid date";
    }
    else{
      if(date.isBefore(DateTime(1960))||date.isAfter(DateTime.now()))
        {
          return "enter a valid date";
        }
      return null;
    }
  }

  void _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime.now()
    ).then((value){
      setState(() {
        dateTime = value!;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(dateTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _showDatePicker,
      keyboardType: TextInputType.datetime,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text)=>validator(), // validate field
      controller: widget.controller,
      obscureText: false,
      style: const TextStyle(
        color: Global.orange,
        fontSize: 18.0,
      ),
      cursorColor: Global.orange,
      decoration: InputDecoration(
          labelText: "Birth Date",
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
          suffixIcon: null,
          labelStyle: const TextStyle(
            color: Global.orange,
          ),
          focusColor: Global.orange
      ),
    );
  }
}
