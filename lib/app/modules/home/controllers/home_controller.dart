import 'package:antrian_guest/app/data/models/service_category.dart';
import 'package:antrian_guest/app/data/services/antrian_services.dart';
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
      }
      change(result.data, status: RxStatus.success());
    } else {
      change(state, status: RxStatus.error('Tidak ada data tersedia'));
    }
  }

  void toggleFullscreen() {
    if (!isFullscreen.value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    isFullscreen.toggle();
  }

  void pilihInstansi(int id) {}
}
