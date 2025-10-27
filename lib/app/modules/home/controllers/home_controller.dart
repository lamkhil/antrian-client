import 'package:antrian_guest/app/data/models/service_category.dart';
import 'package:antrian_guest/app/data/services/antrian_services.dart';
import 'package:antrian_guest/app/global/app_dialog.dart';
import 'package:antrian_guest/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with StateMixin<List<ServiceCategory>> {
  final RxBool isFullscreen = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    change(state, status: RxStatus.loading());
    final result = await AntrianServices.getServiceCategory();

    if (result.success) {
      if (result.data!.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(result.data, status: RxStatus.success());
      return;
    }

    change(state, status: RxStatus.error('Tidak ada data tersedia'));
    return;
  }

  void toggleFullscreen() {
    if (!isFullscreen.value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    isFullscreen.toggle();
  }

  void pilihInstansi(ServiceCategory service) {
    Get.toNamed(Routes.CHOOSE_SERVICE, arguments: service);
  }
}
