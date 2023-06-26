import 'package:ai_trainer/views/pages/entry_point.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../shared/globals.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/wave_widget.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback onClickedSignUp;

  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey= GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validEmail(String? email) {
    if (email != null && !EmailValidator.validate(email.trim())){
      return "Enter a valid email";
    }
    else{
      return null;
    }
  }

  String? validPassword(String? pass) {
    if (pass != null && pass.length<6){
      return "Enter min 6 characters";
    }
    else{
      return null;
    }
  }

  Future _login() async {
    // form validation check - email & password
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    // show progress circle
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.orange,
            strokeWidth: 3,
          ),
        )
    );
    final navigator = Navigator.of(context);
    // try login
    User? user = await login(emailController.text, passwordController.text);
    navigator.pop();
    if (user != null) {
      navigator.pushReplacement(MaterialPageRoute(builder: (context) =>  const EntryPoint()));
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // size of the screen
    final bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        backgroundColor: AppColors.orange,
        body: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyBoardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: AppColors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFieldWidget(
                          hintText: "Email",
                          prefixIconData: Icons.mail_outline,
                          password: false,
                          controller: emailController,
                          validator: validEmail,
                          textInputType: TextInputType.emailAddress,
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
                        SignInButtonWidget(
                          title: "Login",
                          onTap: _login,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                              ),
                              text: 'No account? ',
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.orange,
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
          ],
        ),
      );
  }
}


