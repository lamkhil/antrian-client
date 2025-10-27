import 'dart:math';

import 'package:antrian_guest/app/data/models/service_category.dart';
import 'package:antrian_guest/app/global/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChooseServiceController extends GetxController {
  final ServiceCategory serviceCategory = Get.arguments;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pilihLayanan(Services service) async {
    final context = Get.context!;
    final printer = Get.find<AppController>().flutterThermalPrinterPlugin;

    // 🔹 1. Cek apakah printer sudah terkoneksi
    bool isConnected = Get.find<AppController>().printers
        .where((e) => e.isConnected == true)
        .isNotEmpty;

    Printer? connectedPrinter = Get.find<AppController>().printers
        .where((e) => e.isConnected == true)
        .firstOrNull;

    // 🔹 2. Jika belum terkoneksi, tampilkan dialog pemilihan printer
    if (!isConnected) {
      if (Get.find<AppController>().printers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ Tidak ada printer terdeteksi')),
        );
        return;
      }

      final selected = await showDialog<Printer>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Pilih Printer'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Get.find<AppController>().printers.length,
              itemBuilder: (context, index) {
                final p = Get.find<AppController>().printers[index];
                return ListTile(
                  title: Text(p.name ?? 'Unknown'),
                  subtitle: Text(p.address ?? '-'),
                  onTap: () => Navigator.pop(context, p),
                );
              },
            ),
          ),
        ),
      );

      if (selected == null) return; // jika user batal

      final result = await Get.find<AppController>().flutterThermalPrinterPlugin
          .connect(selected);

      if (!result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Gagal menghubungkan ke printer')),
        );
        return;
      }

      connectedPrinter = selected;
    }

    // 🔹 3. Generate nomor antrian unik

    // 🔹 Siapkan generator ESC/POS
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // 🔹 Data antrian
    final queueNumber = "A${Random().nextInt(900) + 100}";
    final now = DateTime.now();
    final formattedDate = DateFormat(
      'EEEE, dd MMMM yyyy HH:mm:ss',
      'id_ID',
    ).format(now);

    // ===================================================
    //                   LAYOUT CETAK
    // ===================================================
    bytes += generator.text(
      'SISTEM TAMPAN',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.text(
      'Jl. Jimerto No.25-27, Surabaya\nTelp (031) 5312144',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.feed(1);

    bytes += generator.text(
      service.name?.toUpperCase() ?? '-',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.text(
      'Nomor Antrian Anda:',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );

    bytes += generator.feed(1);

    bytes += generator.text(
      queueNumber,
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size3,
        width: PosTextSize.size3,
      ),
    );

    bytes += generator.feed(1);

    bytes += generator.text(
      'SILAHKAN MENUNGGU NOMOR ANTRIAN DIPANGGIL',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      'NOMOR INI HANYA BERLAKU PADA HARI DICETAK',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      formattedDate,
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.feed(1);

    bytes += generator.text(
      'TERIMAKASIH ANDA TELAH TERTIB',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );

    bytes += generator.feed(2);
    bytes += generator.cut();

    // 🔹 Kirim ke printer
    await printer.printData(connectedPrinter!, bytes);
    await printer.disconnect(connectedPrinter);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Tiket $queueNumber berhasil dicetak!')),
    );
  }
}
