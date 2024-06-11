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

import '../../../model/doctormodel.dart';
import '../../../resources/routes/pages.dart';

class DoctorProfileController extends GetxController {
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController speciallityController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  late User firebaseUser;
  TextEditingController datePickerController = TextEditingController();
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController workingDaysController = TextEditingController();
  RxBool isLoading = false.obs;
  late DoctorModel doctorMod;

  @override
  void onInit() {
    doctorMod = Get.arguments != null ? Get.arguments['doctorMod'] : "";
    firebaseUser = Get.arguments != null ? Get.arguments['firebaseUser'] : "";
    super.onInit();
  }

  void onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        );
      },
    );
  }

  void checkValues() {
    uploadData();
  }

  void uploadData() async {
    try {
      isLoading.value = true;
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image selected for upload.");
        }
        return;
      }

      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(doctorMod.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      String fullName = doctorNameController.text.trim();
      String doctorSpeciality = speciallityController.text.trim();
      String email = emailcontroller.text.trim();
      String aboutDoctor = aboutController.text.trim();
      String workingTime = workingTimeController.text.trim();
      String workingDays = workingDaysController.text.trim();
      String doctorAddress = addressController.text.trim();

      // Initialize doctorModel
      DoctorModel doctorModel = DoctorModel(
        uid: doctorMod.uid,

        doctorName: fullName,
        profilepic: imageUrl,
        doctorSpeciality: doctorSpeciality,
        email: email,
        aboutDoctor: aboutDoctor,
        workingTime: workingTime.split(','),
        doctorAddress: doctorAddress,
        workingDays: workingDays.split(','),
        isFavorite: doctorMod.isFavorite, // Preserve the favorite status
      );

      // Update the doctor document in Firestore
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(doctorModel.uid)
          .set(doctorModel.toMap())
          .then((_) {
        if (kDebugMode) {
          print("Doctor Profile Data saved successfully!");
        }
      }).catchError((error) {
        if (kDebugMode) {
          print("Error saving doctor profile data: $error");
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error uploading data: $error");
      }
    }
    isLoading.value = false;
    Get.offAllNamed(Routes.dashboard, arguments: {"id": doctorMod.uid});
  }

  void toggleFavoriteStatus() async {
    try {
      // Toggle the favorite status
      doctorMod.isFavorite = !(doctorMod.isFavorite ?? false);

      // Update the favorite status in Firestore
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(doctorMod.uid)
          .update({
        'isFavorite': doctorMod.isFavorite,
      }).then((_) {
        if (kDebugMode) {
          print("Favorite status updated successfully!");
        }
      }).catchError((error) {
        if (kDebugMode) {
          print("Error updating favorite status: $error");
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error toggling favorite status: $error");
      }
    }
  }
}
