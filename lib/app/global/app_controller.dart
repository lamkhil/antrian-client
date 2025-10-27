import 'dart:async';

import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:get/get.dart';

class AppController extends GetxController
{

  StreamSubscription<List<Printer>>? devicesStreamSubscription;
  final flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

  final RxList<Printer> printers = RxList();


  @override
  void onReady() {
    startScan();
    super.onReady();
  }

  void startScan() async {
    devicesStreamSubscription?.cancel();
    await flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
      ConnectionType.USB,
      ConnectionType.BLE,
      ConnectionType.NETWORK
    ]);
    devicesStreamSubscription = flutterThermalPrinterPlugin.devicesStream
        .listen((List<Printer> event) {
          printers.clear();
          printers.addAll(event);
      printers.removeWhere((element) =>
      element.name == null ||
          element.name == '' ||
          element.name!.toLowerCase().contains("print") == false);
    });
  }

  @override
  void onClose() {
    flutterThermalPrinterPlugin.stopScan();
    devicesStreamSubscription?.cancel();
    super.onClose();
  }
}