import 'dart:io';
import 'package:firebasesample/app/modules/welcome_page/controllers/welcome_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ImagePick extends StatelessWidget {
  const ImagePick({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Column(
        children: [
          Obx(
            () => CircleAvatar(
                radius: height * 0.08,
                backgroundImage: WelcomePageController.image.value == ''
                    ? const AssetImage(
                        "assets/avatar.png",
                      )
                    : Image.file(File(WelcomePageController.image.value))
                        .image),
          )
        ],
      ),
      onTap: () {
        Get.defaultDialog(
            title: "Choose image",
            middleText: "",
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      WelcomePageController.pickImageFromCamera();
                      Get.back();
                    },
                    icon: const Icon(Icons.camera_alt_outlined)),
                IconButton(
                    onPressed: () {
                      WelcomePageController.pickImageFromGallery();
                      Get.back();
                    },
                    icon: const Icon(Icons.filter))
              ],
            ));
      },
    );
  }
}
