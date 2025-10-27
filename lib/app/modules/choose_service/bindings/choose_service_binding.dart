import 'package:get/get.dart';

import '../controllers/choose_service_controller.dart';

class ChooseServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseServiceController>(
      () => ChooseServiceController(),
    );
  }
}
