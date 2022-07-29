
import 'package:firebasesample/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  final auth = Get.put(AuthController());
  final count = 0.obs;


  // void login() async {
  //   GoogleSignInAccount? googleSignInAccount = await auth.googleSignIn.signIn();
  //   if (googleSignInAccount == null) {
  //     return;
  //   } else {
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken);
  //     await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  //   }
  // }

 
  void increment() => count.value++;
}
