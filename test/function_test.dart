import 'package:ai_trainer/shared/validators.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  test("Is email empty", (){
    String? result = Validators.validateEmail('');
    expect(result, "Enter a valid email");
  });
  test("Is email valid", (){
    String? result = Validators.validateEmail('koko.gmail.com');
    expect(result, "Enter a valid email");
  });
  test("Is email correct", (){
    String? result = Validators.validateEmail('lotty@gmail.com');
    expect(result, null);
  });
  test("Is password contains less then 1 character", (){
    String? result = Validators.validatePassword('');
    expect(result, "Enter min 6 characters");
  });
  test("Is password very short", (){
    String? result = Validators.validatePassword('12345');
    expect(result, "Enter min 6 characters");
  });
  test("Correct password ", (){
    String? result = Validators.validatePassword('123456');
    expect(result, null);
  });
test("Is height valid input", (){
    String? result = Validators.validateHeight('asdf');
    expect(result, "Enter numbers only");
  });
test("is height non negative numbers", (){
    String? result = Validators.validateHeight('-44');
    expect(result, "Enter a valid height");
  });
test("correct height", (){
    String? result = Validators.validateHeight('180');
    expect(result, null);
  });
test("Is not empty name", (){
    String? result = Validators.validateName('');
    expect(result, "Enter your name");
  });
test("Correct name", (){
    String? result = Validators.validateName("Elad");
    expect(result, null);
  });
test("Is date empty", (){
    String? result = Validators.validateDate(null);
    expect(result, "enter your birth date");
  });
test("Is weight valid input", (){
    String? result = Validators.validateHeight('asdf');
    expect(result, "Enter numbers only");
  });
test("is weight non negative numbers", (){
    String? result = Validators.validateHeight('-44');
    expect(result, "Enter a valid height");
  });
test("correct weight", (){
    String? result = Validators.validateHeight('70');
    expect(result, null);
  });
}