import 'package:firebasesample/app/modules/welcome_page/views/util/cutom_dialog.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/show/bindings/show_binding.dart';
import '../modules/show/views/show_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/welcome_page/bindings/welcome_page_binding.dart';
import '../modules/welcome_page/views/welcome_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () =>  SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.welcomePage,
      page: () => WelcomePageView(
        // ignore: null_check_always_fails
        email: null!,
      ),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: _Paths.show,
      page: () => ShowView(),
      binding: ShowBinding(),
    ),
    GetPage(
      name: _Paths.dialog,
      page: () =>  const CustomDialog(),
      binding: ShowBinding(),
    ),
  ];
}
