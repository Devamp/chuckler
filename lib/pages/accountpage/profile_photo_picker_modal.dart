import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:chuckler/Session.dart';
import 'package:chuckler/DatabaseQueries.dart';
class ProfilePhotoPickerModal extends StatelessWidget {
  final String username;
  final String? img;

  ProfilePhotoPickerModal({super.key, required this.username, this.img});

  @override
  build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    FirebaseFirestore firestore = Provider.of<FirebaseFirestore>(context, listen: false);
    return InkWell(
        onTap: () async {
          UserService userService = Provider.of<UserService>(context, listen: false);
          //TODO ENSURE THAT IMAGE PICKER HAS PROPER RIGHTS FOR ANDROID AND IOS
          ImagePicker imagePicker = ImagePicker();
          XFile? file =
              await imagePicker.pickImage(source: ImageSource.gallery);

          if (file == null) {
            return;
          }

          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDir = referenceRoot.child('ProfilePhotos');
          //Create a universal unique id for the file

          Reference imageToUpload = referenceDir.child(username);
          try {
            //TODO MAKE SURE THAT AUTHOR IS ADDED TO META DATA AND ONLY THE AUTHOR CAN EDIT
            await imageToUpload.putFile(File(file.path));
            String pfp =await imageToUpload.getDownloadURL();
            if(pfp != userService.profilePhoto) {
              userService.setProfilePhoto(pfp);
              updateProfilePhoto(firestore, pfp, username);
            }
          } catch (error) {}
        },
        child: img == ""
            ? ProfilePicture(
                name: username,
                radius: 50,
                fontsize: 40,
              )
            : Container(width: 50 * 2,
      height: 50 * 2,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover, // Adjust as needed
          image: NetworkImage(img!), // Use NetworkImage for network image
        ),
      )));
  }
}
