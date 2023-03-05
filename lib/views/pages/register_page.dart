import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';
import '../../shared/globals.dart';
import '../../shared/utils.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/wave_widget.dart';
import 'home_page.dart';

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
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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

  // TODO: write register function
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
    // try login
    LoginError loginError =
        await login(emailController.text, passwordController.text);
    switch (loginError) {
      case LoginError.success:
        // on success - navigate to home page
        navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case LoginError.userNotExist:
        navigator.pop(); // stop progress circle
        Utils.showSnackBar("Incorrect email or password."); // error message
        break;
      case LoginError.errorDbConnection:
        navigator.pop(); // stop progress circle
        Utils.showSnackBar("Something went wrong. Please try again later.");
        break;
      default:
        navigator.pop(); // stop progress circle
        break;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldWidget(
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
                hintText: "Password",
                prefixIconData: Icons.lock_outline,
                password: true,
                controller: passwordController,
                validator: validPassword,
              ),
              const SizedBox(
                height: 10.0,
              ),
              // TODO: function to compare passwords
              TextFieldWidget(
                hintText: "Confirm Password",
                prefixIconData: Icons.lock_outline,
                password: true,
                controller: confirmPasswordController,
                validator: null,
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
                  style: TextStyle(
                    color: Global.white,
                    fontSize: 20,
                  ),
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedLogin,
                      text: 'Login',
                      style: TextStyle(
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
    );
  }
}
