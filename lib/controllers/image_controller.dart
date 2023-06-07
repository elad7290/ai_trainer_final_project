import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../db_access/image_db.dart';


class ImageController {
  File? image;

   Future chooseImageFromGallery() async {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage!= null){
        File pickedFile = File(pickedImage.path);
        image = pickedFile;
      }

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
}