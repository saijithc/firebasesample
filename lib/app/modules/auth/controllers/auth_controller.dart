import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesample/app/modules/login/views/login_view.dart';
import 'package:firebasesample/app/modules/welcome_page/controllers/welcome_page_controller.dart';
import 'package:firebasesample/app/modules/welcome_page/views/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  static late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() async {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(LoginView());
    } else {
      WelcomePageController.collectionReference = FirebaseFirestore.instance.collection(user.email.toString());
      Get.offAll(WelcomePageView(
        email: user.email!,
      ));
    }
  }

  //<<<<<<<<<...............Sign up ...............................>>>>>>>>>>.
  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("", " ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 252, 252, 252)),
          ));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(" ", "   ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
            "Login failed",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 252, 252, 252)),
          ));
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAll(LoginView());
  }
}

  //login details
  // late GoogleSignIn googleSignIn;
  // var isSignIn = false.obs;
  // GoogleSignInAccount get User => _user;



// googleSignIn = GoogleSignIn();
    // ever(isSignIn, handleAuthStateChanged);
    // isSignIn.value = auth.currentUser != null;
    // auth.authStateChanges().listen((event) {
    //   isSignIn.value = event != null;
    // });


    // StreamBuilder(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   // initialData: initialData,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasData) {
    //       user = snapshot.data.toString() as User?;
    //     }else if(snapshot.hasError){

    //     }
    //   },
    // );


//  await googleSignIn.disconnect();

  // Future googleLogin() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) return;
  //   _user = googleUser as Rx<User?>;
  //   final googleAuth = await googleUser.authentication;
  //   final Credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //   await FirebaseAuth.instance.signInWithCredential(Credential);

  //   update();
  // }
  //void increment() => count.value++;

//   handleAuthStateChanged(isLoggedIn) {
//     if (isLoggedIn) {
//       Get.offAll(
//           WelcomePageView(email: auth.currentUser!.displayName.toString()));
//     } else {
//       Get.offAll(LoginView());
//     }
//   }