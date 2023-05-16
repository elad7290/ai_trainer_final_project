import 'package:ai_trainer/views/pages/entry_point.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../controllers/login_controller.dart';
import '../../shared/globals.dart';
import '../../shared/utils.dart';
import '../widgets/datefield_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const RegisterPage({
    Key? key,
    required this.onClickedLogin,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    //
    nameController.dispose();
    birthDateController.dispose();
    weightController.dispose();
    heightController.dispose();

    super.dispose();
  }

  String? validWeight(String? height){
    var h = double.tryParse(height!);
    if(h == null){
      return "Enter numbers only";
    }
    if(h<0){
      return "Enter a valid height";
    }
  }

  String? validHeight(String? weight){
    var w = double.tryParse(weight!);
    if(w == null){
      return "Enter numbers only";
    }
    if(w<0){
      return "Enter a valid weight";
    }
  }

  String? validEmail(String? email) {
    if (email != null && !EmailValidator.validate(email)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  String? validPassword(String? pass) {
    if (pass != null && pass.length < 6) {
      return "Enter min 6 characters";
    } else {
      return null;
    }
  }

  String? validName(String? name) {
    if (name != null && name.isEmpty) {
      return "Enter your name";
    } else {
      return null;
    }
  }

  String? validConfirmPassword(String? confPass) {
    if (confPass != null && confPass != passwordController.text) {
      return "Passwords are not equal";
    } else {
      return null;
    }
  }

  Future _register() async {
    // form validation check - email & password
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    // show progress circle
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Global.orange,
                strokeWidth: 3,
              ),
            ));
    final navigator = Navigator.of(context);
    // try register
    String? error = await register(emailController.text, passwordController.text, nameController.text,birthDateController.text,weightController.text,heightController.text);
    navigator.pop(); // stop progress circle
    if (error != null) {
      Utils.showSnackBar(error); // error message
    } else {
      // on success - navigate to home page
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => EntryPoint()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.black,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldWidget(
                    textInputType: TextInputType.name,
                    hintText: "Name",
                    prefixIconData: Icons.person,
                    password: false,
                    controller:nameController,
                    validator: validName,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DateFieldWidget(
                    prefixIconData: Icons.cake,
                    controller:birthDateController,
                    validator: validName,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    hintText: "Weight",
                    textInputType: TextInputType.number,
                    prefixIconData: Icons.monitor_weight,
                    password: false,
                    controller:weightController,
                    validator: validWeight,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    hintText: "Height",
                    textInputType: TextInputType.number,
                    prefixIconData: Icons.height,
                    password: false,
                    controller:heightController,
                    validator: validHeight,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    textInputType: TextInputType.emailAddress,
                    hintText: "Email",
                    prefixIconData: Icons.mail_outline,
                    password: false,
                    controller: emailController,
                    validator: validEmail,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Password",
                    prefixIconData: Icons.lock_outline,
                    password: true,
                    controller: passwordController,
                    validator: validPassword,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    prefixIconData: Icons.lock_outline,
                    password: true,
                    controller: confirmPasswordController,
                    validator: validConfirmPassword,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SignInButtonWidget(
                    title: "Sign Up",
                    onTap: _register,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Global.white,
                        fontSize: 20,
                      ),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedLogin,
                          text: 'Login',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Global.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
