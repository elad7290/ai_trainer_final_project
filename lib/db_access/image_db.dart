import 'dart:io';
import 'package:ai_trainer/controllers/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ImageDB{
  static var storage = FirebaseStorage.instance;

  static Future<String> uploadImageToStorage(File image)async{
    Reference reference = storage.ref().child('profile_images').child(getUserAuth().uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl =  await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}