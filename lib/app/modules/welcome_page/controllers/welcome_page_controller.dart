import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WelcomePageController extends GetxController {
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController numbercontroller = TextEditingController();
  static RxString image = ''.obs;
  static String url = '';
  static String img = '';
  static RxBool dialog = false.obs;
  static CollectionReference? collectionReference;
  static late String user;
 
  @override
  void onInit() {
    super.onInit();

    user = Get.arguments;
  }

// store image
  static storingImage() async {
    try {
      url = '';
      user = FirebaseAuth.instance.currentUser!.uid;
      // log("...................................user...................user......user.....${user}");
      final ref = FirebaseStorage.instance.ref().child(user).child('$user/images');
      UploadTask uploadTask = ref.putFile(File(image.value));
      final snapshot = await uploadTask;
      url = await snapshot.ref.getDownloadURL();
    } catch (e) {
      log(e.toString());
    }
  }

  static pickImageFromGallery() async {
    try {
      image.value = '';
      img = '';
      XFile? pickedImage =await ImagePicker().pickImage(source: ImageSource.gallery);
      img = pickedImage!.name;
      image.value = pickedImage.path;
      log('..........................image ${image.value}');
    } catch (e) {
      Get.snackbar(
        "title",
        "Error",
      );
    }
  }

  static pickImageFromCamera() async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      img = pickedImage!.name;
      image.value = pickedImage.path;
    } catch (e) {
      Get.snackbar(
        "title",
        "Error",
      );
    }
  }

  static void buidAddEdit(
      {required String name,
      required int addEditflag,
      required String docId}) async {
    await storingImage();
    saveUpdate(namecontroller.text, numbercontroller.text, docId, addEditflag);
  }

  static void saveUpdate(
      String name, String num, String docId, int addEditflag) {
    if (addEditflag == 1) {
      collectionReference!
          .add({'name': name, 'number': num, 'img': url}).whenComplete(() {
        Get.snackbar("Contact Added", "Contact added sucessfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255));
      });
      url = '';
      image.value = '';
      img = '';
    } else if (addEditflag == 2) {
      collectionReference!
          .doc(docId)
          .update({'name': name, 'number': num, 'img': url}).whenComplete(() {
        Get.snackbar("Contact updated", "Contact updated sucessfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255));
      });
      url = '';
      image.value = '';
      img = '';
    }
  }

 
}
