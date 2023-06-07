import 'package:ai_trainer/controllers/image_controller.dart';
import 'package:ai_trainer/views/pages/entry_point.dart';
import 'package:ai_trainer/views/widgets/image_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../shared/globals.dart';
import '../../shared/utils.dart';
import '../../shared/validators.dart';
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
  final imageController = ImageController();

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
                color: AppColors.orange,
                strokeWidth: 3,
              ),
            ));
    final navigator = Navigator.of(context);
    // try register
    String? error = await register(emailController.text, passwordController.text, nameController.text,birthDateController.text,weightController.text,heightController.text,imageController.image);
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
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 15.0),
                  ImageWidget(controller: imageController,profile_image: null),
                  const SizedBox(height: 15.0),
                  TextFieldWidget(
                    textInputType: TextInputType.name,
                    hintText: "Name",
                    prefixIconData: Icons.person,
                    password: false,
                    controller:nameController,
                    validator: Validators.validateName,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DateFieldWidget(
                    prefixIconData: Icons.cake,
                    controller:birthDateController,
                    validator: Validators.validateName,
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
                    validator: Validators.validateWeight,
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
                    validator: Validators.validateHeight,
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
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Password",
                    prefixIconData: Icons.fingerprint_outlined,
                    password: true,
                    controller: passwordController,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    prefixIconData: Icons.fingerprint_outlined,
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
                        color: AppColors.white,
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
    );
  }
}
