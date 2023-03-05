import 'package:ai_trainer/views/pages/home_page.dart';
import 'package:ai_trainer/views/widgets/sign_up_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../controllers/login_controller.dart';
import '../../shared/globals.dart';
import '../../shared/utils.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/wave_widget.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

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
    if (email != null && !EmailValidator.validate(email)){
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

  Future tryLogin() async {
    // form validation check - email & password
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    // show progress circle
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Global.orange,
            strokeWidth: 3,
          ),
        )
    );
    final navigator = Navigator.of(context);
    // try login
    LoginError loginError = await login(emailController.text, passwordController.text);
    //TODO: handle errors
    switch (loginError) {
      case LoginError.success:
        // on success - navigate to home page
        navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
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
        print(loginError);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // size of the screen
    final bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        backgroundColor: Global.orange,
        body: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyBoardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: Global.black,
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
                      color: Global.black,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                    SignInButtonWidget(
                      title: "Login",
                      onTap: tryLogin,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SignUpButtonWidget(
                      // TODO: on pressed, register
                      title: "Sign Up",
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}


