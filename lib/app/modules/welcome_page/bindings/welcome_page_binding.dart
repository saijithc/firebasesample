import 'package:get/get.dart';

import '../controllers/welcome_page_controller.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomePageController>(
      () => WelcomePageController(),
    );
  }
}
