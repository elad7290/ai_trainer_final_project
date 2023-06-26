import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class Validators{

  static String? validateWeight(String? weight){
    var h = double.tryParse(weight!);
    if(h == null){
      return "Enter numbers only";
    }
    if(h<0){
      return "Enter a valid height";
    }
    return null;
  }

  static String? validateHeight(String? height ){
    var w = double.tryParse(height!);
    if(w == null){
      return "Enter numbers only";
    }
    if(w<0){
      return "Enter a valid height";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email != null && !EmailValidator.validate(email)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? pass) {
    if (pass != null && pass.length < 6) {
      return "Enter min 6 characters";
    } else {
      return null;
    }
  }

  static String? validateName(String? name) {
    if (name != null && name.isEmpty) {
      return "Enter your name";
    } else {
      return null;
    }
  }

  static String? validateDate(String? text){
    try {
      if (text == null) {
        return "enter your birth date";
      }
      var date = DateFormat('dd-MM-yyyy').parse(text);
      if(date.isBefore(DateTime(1960))||date.isAfter(DateTime.now()))
      {
        return "enter a valid date";
      }
      return null;
    } catch (e) {
      return "enter a valid date";
    }
  }


}