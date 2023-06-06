import 'package:ai_trainer/controllers/image_controller.dart';
import 'package:ai_trainer/controllers/user_controller.dart';
import 'package:ai_trainer/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  var imageController = Get.put(ImageController());

  Future saveChanges() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    //show progress circle
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
    await editUser(emailController.text, passwordController.text, nameController.text, birthDateController.text, weightController.text, heightController.text,imageController.proflieImage, widget.user);
    navigator.pop();
    setState(() {
      clearData();
    });
  }

  void pickImage(){
    imageController.chooseImageFromGallery();
  }

  void clearData() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    birthDateController.clear();
    weightController.clear();
    heightController.clear();
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
          style: TextStyle(color: Global.orange),
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Global.white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: widget.user.profile_image != null?  DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.user.profile_image!
                                )
                            ) : null,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Global.white),
                                color: Colors.orangeAccent),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              color: Global.black,
                              onPressed: pickImage,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                EditText(
                  label: 'Name',
                  placeHoler: widget.user.name,
                  isPassword: false,
                  controller: nameController,
                  validator: Validators.validateName,
                  textInputType: TextInputType.name,
                ),
                EditText(
                  label: 'Email',
                  placeHoler: widget.user.email,
                  isPassword: false,
                  validator: Validators.validateEmail,
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                EditText(
                  label: 'Password',
                  placeHoler: '*******',
                  isPassword: true,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                  textInputType: TextInputType.text,
                ),
                EditText(
                  label: 'Birth Date',
                  placeHoler:
                      DateFormat('dd-MM-yyyy').format(widget.user.birthDate),
                  isPassword: false,
                  controller: birthDateController,
                  validator: Validators.validateDate,
                  textInputType: TextInputType.datetime,
                ),
                EditText(
                  label: 'Weight',
                  placeHoler: widget.user.weight.toString(),
                  isPassword: false,
                  controller: weightController,
                  validator: Validators.validateWeight,
                  textInputType: TextInputType.number,
                ),
                EditText(
                  label: 'Hight',
                  placeHoler: widget.user.height.toString(),
                  isPassword: false,
                  controller: heightController,
                  validator: Validators.validateHeight,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: saveChanges,
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Global.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
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
