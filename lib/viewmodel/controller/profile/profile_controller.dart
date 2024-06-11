import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../model/usermodel.dart';
import '../../../resources/routes/pages.dart';

class ProfileController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController genderController = TextEditingController();
  late UserModel userModel;
  late User firebaseUser;
  TextEditingController datePickerController = TextEditingController();
  TextEditingController fullNamecontroller = TextEditingController();
  RxBool isLoading=false.obs;
  @override
  void onInit() {
    userModel = Get.arguments != null ? Get.arguments['userModel'] : "";
    firebaseUser = Get.arguments != null ? Get.arguments['firebaseUser'] : "";
    super.onInit();
  }

  void onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  File? imageFile;

  TextEditingController fullNamecontrolller = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropimagee(pickedFile);
    }
  }

  void cropimagee(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 20,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if (croppedFile != null) {
      imageFile = File(croppedFile.path); // Convert CroppedFile to File
      update();
    }
  }

  void showPhotoOption() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text("Select from Gallery"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera),
                title: const Text("Select from Camera"),
              ),
            ]),
          );
        });
  }

  void checkValues() {
    uploadData();
  }

  void uploadData() async {
    try {
      isLoading.value=true;
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image selected for upload.");
        }
        return;
      }

      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(userModel.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      String fullName = namecontroller.text.trim();
      String date = datePickerController.text.trim();
      String gender = genderController.text.trim();

      userModel.fullname = fullName;
      userModel.profilepic = imageUrl;
      userModel.date=date;
      userModel.gender=gender;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.uid.toString())
          .set(userModel.toMap())
          .then((_) {
        if (kDebugMode) {
          print("Profile Id: ${userModel.uid}");
          print("Data uploaded successfully!");
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error uploading data: $error");
      }
    }
    isLoading.value=false;
    Get.toNamed(Routes.dashboard,arguments: {
      "id": userModel.uid
    });
  }
}
