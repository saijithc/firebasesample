import 'package:flutter/material.dart';
import '../../controllers/welcome_page_controller.dart';
import '../image_picker.dart';
import 'package:get/get.dart';

class CustomDialog extends GetView {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(81, 0, 0, 0),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ColoredBox(
            color: Colors.white,
            child: SizedBox(
              height: height * 0.5,
              width: width * 0.78,
              child: Center(
                child: SizedBox(
                  height: 460,
                  width: 250,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.013,
                      ),
                      const ImagePick(),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextField(
                        controller: WelcomePageController.namecontroller,
                        decoration: InputDecoration(
                            hintText: "Name",
                            prefixIcon: const Icon(Icons.person),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: WelcomePageController.numbercontroller,
                        decoration: InputDecoration(
                            hintText: "Number",
                            prefixIcon: const Icon(Icons.phone),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              WelcomePageController.dialog.value = false;
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: const ColoredBox(
                                color: Colors.teal,
                                child: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (WelcomePageController
                                      .numbercontroller.text.isNotEmpty &&
                                  WelcomePageController
                                          .numbercontroller.text.length >=
                                      10 &&
                                  WelcomePageController
                                          .numbercontroller.text.length <=
                                      12 &&
                                  WelcomePageController
                                      .namecontroller.text.isNotEmpty) {
                                WelcomePageController.buidAddEdit(
                                    name: 'Add', addEditflag: 1, docId: '');
                                WelcomePageController.dialog.value = false;
                                Get.snackbar(
                                    "Processin", "it may take few seconds",
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color.fromARGB(
                                        255, 155, 247, 158),
                                    margin: const EdgeInsets.all(25));
                              } else {
                                Get.snackbar("Adding failed",
                                    "name and number are required and mobile number should contain minimum ten digit !",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: const ColoredBox(
                                color: Colors.teal,
                                child: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
