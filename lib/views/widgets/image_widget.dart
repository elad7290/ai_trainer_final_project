import 'dart:io';
import 'package:flutter/material.dart';
import '../../controllers/image_controller.dart';
import '../../shared/globals.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key, required this.controller, required this.profile_image}) : super(key: key);

  final ImageController controller;
  final String? profile_image;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {

  File? image;
  bool isImageUpdated = false;

  DecorationImage? displayImage (){
    if(isImageUpdated && image != null){
      return DecorationImage(image: FileImage(image!),fit: BoxFit.cover);
    }
    if (!isImageUpdated && widget.profile_image!= null){
      return DecorationImage(image: NetworkImage(widget.profile_image!),fit: BoxFit.cover);
    }
    return null;
  }

  void pickImage() async{
    await widget.controller.chooseImageFromGallery();
    setState(() {
      if (widget.controller.image != null) {
        image = widget.controller.image;
        isImageUpdated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              image: displayImage(),
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
    );
  }
}
