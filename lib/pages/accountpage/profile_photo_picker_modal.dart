import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ProfilePhotoPickerModal extends StatelessWidget {
  get future => null;

  @override
  build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: () async {
              //TODO ENSURE THAT IMAGE PICKER HAS PROPER RIGHTS FOR ANDROID AND IOS
              ImagePicker imagePicker = ImagePicker();
              XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

              if(file == null){
                return;
              }

              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDir = referenceRoot.child('ProfilePhotos');
              //Create a universal unique id for the file
              var uuid = const Uuid();
              String uniqueFileName = uuid.v4();

              Reference imageToUpload = referenceDir.child(uniqueFileName);
              try {
                await imageToUpload.putFile(File(file.path));
                print(await imageToUpload.getDownloadURL());
              }
              catch(error){

              }
        },
        child: ProfilePicture(
          name: "HERE",
          radius: 50,
          fontsize: 40,
        ));
  }
}
