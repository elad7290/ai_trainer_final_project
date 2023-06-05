import 'package:flutter/material.dart';
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
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/ai-trainer-db.appspot.com/o/profile_images%2F24863.jpg?alt=media&token=cca85cac-c9f9-4285-bdef-17f636f76969'))),
                    ),
                    Positioned(
                      bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Global.white
                            ),
                            color: Colors.orangeAccent
                          ),
                          child: Icon(Icons.edit,color: Global.black,),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                ),
              EditText(label: 'Name', placeHoler: 'elad', isPassword: false),
              EditText(label: 'Email', placeHoler: 'elad', isPassword: false),
              EditText(label: 'Password', placeHoler: '*******', isPassword: true),
              EditText(label: 'Confirm Password', placeHoler: '*******', isPassword: true),
              EditText(label: 'Birth Date', placeHoler: 'elad', isPassword: false),
              EditText(label: 'Weight', placeHoler: 'elad', isPassword: false),
              EditText(label: 'Hight', placeHoler: 'elad', isPassword: false),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){},
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
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
