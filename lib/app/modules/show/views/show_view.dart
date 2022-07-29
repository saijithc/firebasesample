import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasesample/app/modules/welcome_page/controllers/welcome_page_controller.dart';
import 'package:firebasesample/app/modules/welcome_page/views/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/show_controller.dart';

class ShowView extends GetView<ShowController> {
  ShowView({
    Key? key,
  }) : super(key: key);
  final CollectionReference ref = FirebaseFirestore.instance
      .collection(AuthController.user.value!.email.toString());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.5,
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircularProgressIndicator(),
                ],
              );
            }
            if (snapshot.data!.docs.isEmpty == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Center(
                      child: Text(
                    "No contacts  found !",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 214, 99),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(doc['img']),
                        ),
                        title: Text(doc['name'].toString().toUpperCase()),
                        subtitle: Text(
                          doc['number'].toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "Options",
                                  middleText: "",
                                  content: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: ColoredBox(
                                          color: Colors.amber,
                                          child: ListTile(
                                            title: const Center(
                                                child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                            onTap: () {
                                              WelcomePageController
                                                  .namecontroller
                                                  .text = doc['name'];
                                              WelcomePageController
                                                  .numbercontroller
                                                  .text = doc['number'];
                                              Get.back();
                                              Get.defaultDialog(
                                                  confirmTextColor: Colors.teal,
                                                  cancelTextColor: Colors.teal,
                                                  buttonColor: Colors.black,
                                                  title: "Update",
                                                  middleText: "",
                                                  content: Column(
                                                    children: [
                                                      const ImagePick(),
                                                      SizedBox(
                                                        height: height * 0.015,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            WelcomePageController
                                                                .namecontroller,
                                                        decoration: InputDecoration(
                                                            hintText: "Name",
                                                            prefixIcon:
                                                                const Icon(Icons
                                                                    .person),
                                                            focusColor:
                                                                Colors.black,
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30))),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              height * 0.02),
                                                      TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            WelcomePageController
                                                                .numbercontroller,
                                                        decoration: InputDecoration(
                                                            hintText: "Number",
                                                            prefixIcon:
                                                                const Icon(Icons
                                                                    .phone),
                                                            focusColor:
                                                                Colors.black,
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30))),
                                                      ),
                                                    ],
                                                  ),
                                                  onCancel: () {
                                                    Get.back();
                                                  },
                                                  onConfirm: () {
                                                    if (WelcomePageController
                                                            .numbercontroller
                                                            .text
                                                            .isNotEmpty &&
                                                        WelcomePageController
                                                                .numbercontroller
                                                                .text
                                                                .length >=
                                                            10 &&
                                                        WelcomePageController
                                                                .numbercontroller
                                                                .text
                                                                .length <=
                                                            12 &&
                                                        WelcomePageController
                                                            .namecontroller
                                                            .text
                                                            .isNotEmpty) {
                                                      WelcomePageController
                                                          .buidAddEdit(
                                                              name: 'Update',
                                                              addEditflag: 2,
                                                              docId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id);
                                                      Get.back();
                                                      Get.snackbar("Processing",
                                                          "it may take few seconds",
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  155,
                                                                  247,
                                                                  158),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(25));
                                                    } else {
                                                      Get.snackbar(
                                                          "Adding failed",
                                                          "name and number are required",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                          colorText:
                                                              Colors.white);
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.02),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: ColoredBox(
                                          color: Colors.amber,
                                          child: ListTile(
                                            title: const Center(
                                                child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                            onTap: () {
                                              snapshot
                                                  .data!.docs[index].reference
                                                  .delete();
                                              Get.back();
                                              Get.snackbar("Contact Deleted",
                                                  "Contact deleted sucessfully",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 241, 44, 44));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Color.fromARGB(255, 238, 237, 237),
                            )),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
