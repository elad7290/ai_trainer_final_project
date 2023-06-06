import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ImageController extends GetxController {
  late Rx<File?> pickedFile;
  File? get proflieImage => pickedFile.value;

  void chooseImageFromGallery() async {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage!= null){
        Get.snackbar("Profile Image", "you have successfully selected your profile image.", duration: const Duration(seconds: 3));
      }
      pickedFile = Rx<File?>(File(pickedImage!.path));

  }

  void chooseImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedImage!= null){
      Get.snackbar("Profile Image", "you have successfully selected your profile image.", duration: const Duration(seconds: 3));
    }
    pickedFile = Rx<File?>(File(pickedImage!.path));

  }


}