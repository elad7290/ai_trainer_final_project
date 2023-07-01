import 'package:ai_trainer/controllers/image_controller.dart';
import 'package:ai_trainer/controllers/user_controller.dart';
import 'package:ai_trainer/shared/validators.dart';
import 'package:ai_trainer/views/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../shared/globals.dart';
import '../widgets/edit_text_widget.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imageController = ImageController();

  Future saveChanges() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    //show progress circle
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
    await editUser(emailController.text, passwordController.text, nameController.text, birthDateController.text, weightController.text, heightController.text,imageController.image, widget.user);
    await waitTwoSeconds();
    navigator.pop();
    setState(() {
      clearData();
    });
  }

  void clearData() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    birthDateController.clear();
    weightController.clear();
    heightController.clear();
  }

  Future<void> waitTwoSeconds() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    // Code to be executed after the 2-second delay
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    birthDateController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.orange),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 20,
          right: 15,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                ImageWidget(controller: imageController, profile_image: widget.user.profile_image),
                const SizedBox(
                  height: 30,
                ),
                EditText(
                  label: 'Name',
                  placeHolder: widget.user.name,
                  isPassword: false,
                  controller: nameController,
                  validator: Validators.validateName,
                  textInputType: TextInputType.name,
                ),
                EditText(
                  label: 'Email',
                  placeHolder: widget.user.email,
                  isPassword: false,
                  validator: Validators.validateEmail,
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                EditText(
                  label: 'Password',
                  placeHolder: '*******',
                  isPassword: true,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                  textInputType: TextInputType.text,
                ),
                EditText(
                  label: 'Birth Date',
                  placeHolder:
                      DateFormat('dd-MM-yyyy').format(widget.user.birthDate),
                  isPassword: false,
                  controller: birthDateController,
                  validator: Validators.validateDate,
                  textInputType: TextInputType.datetime,
                ),
                EditText(
                  label: 'Weight',
                  placeHolder: widget.user.weight.toString(),
                  isPassword: false,
                  controller: weightController,
                  validator: Validators.validateWeight,
                  textInputType: TextInputType.number,
                ),
                EditText(
                  label: 'Hight',
                  placeHolder: widget.user.height.toString(),
                  isPassword: false,
                  controller: heightController,
                  validator: Validators.validateHeight,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: saveChanges,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
