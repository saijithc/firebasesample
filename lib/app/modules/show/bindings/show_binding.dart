import 'package:get/get.dart';

import '../controllers/show_controller.dart';

class ShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowController>(
      () => ShowController(),
    );
  }
}
