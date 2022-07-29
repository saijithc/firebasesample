import 'package:firebasesample/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
   SignupView({Key? key}) : super(key: key);
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final confirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.015
              ),
              Container(
                height: height * 0.29, //This is the important part for you
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/contact.gif"),
                        fit: BoxFit.fill))        
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        "Create your account",
                        style: TextStyle(
                            color: Color.fromARGB(255, 133, 133, 133)),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: "your email",
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: const Icon(Icons.key),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: confirm,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "confirm password",
                            prefixIcon: const Icon(Icons.key),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text(
                          //   "Forgot password ?",
                          //   style: TextStyle(
                          //       color: Colors.blue, fontWeight: FontWeight.bold),
                          // ),
                          SizedBox(
                            width: width * 0.85,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal),
                                onPressed: () {
                                  if (confirm.text == passwordController.text) {
                                    AuthController.instance.register(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                  } else {
                                    Get.snackbar("", "  ",
                                        backgroundColor: Colors.red,
                                        titleText: const Text(
                                          "check password",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                },
                                child: const Text("Sign up")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.014,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Sign up with Google  ',
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // AuthController.instance.googleLogin();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: height * 0.045,
                              child: CircleAvatar(
                                radius: height * 0.04,
                                backgroundImage: const AssetImage(
                                    "assets/604199df880fb029291ddd7c382e828b.jpg"),
                              ),
                            ),
                          )
                        ],
                      )

                      // SizedBox(height: height * 0.2),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: const [
                      //         Text(
                      //           "Don't have an account ? ",
                      //           style: TextStyle(
                      //               color: Color.fromARGB(255, 161, 161, 161)),
                      //         ),
                      //         Text(
                      //           "Create",
                      //           style: TextStyle(
                      //               color: Colors.blue,
                      //               fontWeight: FontWeight.w500),
                      //         )
                      //       ],
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
