import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../db_access/image_db.dart';


class ImageController extends GetxController {
  Rx<File?>? pickedFile;
  File? get proflieImage => pickedFile?.value;

  Future chooseImageFromGallery() async {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage!= null){
        Get.snackbar("Profile Image", "you have successfully selected your profile image.");
      }
      pickedFile = Rx<File?>(File(pickedImage!.path));
  }

  void chooseImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedImage!= null){
      Get.snackbar("Profile Image", "you have successfully selected your profile image.");
    }
    pickedFile = Rx<File?>(File(pickedImage!.path));

  }
  static Future<String?> uploadImageToStorage (File? image) async {
    if(image == null) return null;
    try{
      return await ImageDB.uploadImageToStorage(image);
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  @override
  void dispose() {
    pickedFile?.close();
    super.dispose();
  }


}