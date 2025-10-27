import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc), // slate-50
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff8fafc),
              Color(0xff94a3b8),
            ], // slate-50 -> slate-400
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🧭 Header Sticky
              GestureDetector(
                onTap: controller.toggleFullscreen,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: const Border(
                      bottom: BorderSide(color: Color(0xffe2e8f0)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                            colors: [Color(0xff14b8a6), Color(0xff0d9488)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "D",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sistem Tampan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Sistem Antrian",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff64748b),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 📋 Content Scrollable
              Expanded(
                child: controller.obx(
                  (state) => SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: state!.map((item) {
                        return GestureDetector(
                          onTap: () => controller.pilihInstansi(item),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            constraints: const BoxConstraints(maxWidth: 300),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xfff0fdfa),
                                        Color(0xffccfbf1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.network(item.iconUrl??''),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e293b),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.description ?? '',
                                        style: const TextStyle(
                                          color: Color(0xff64748b),
                                          fontSize: 13,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  onEmpty: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tidak ada data tersedia"),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          controller.getData();
                        },
                        child: const Text("Muat Ulang"),
                      ),
                    ],
                  ),
                  onLoading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          controller.getData();
                        },
                        child: const Text("Muat Ulang"),
                      ),
                    ],
                  ),
                  onError: (message)=>Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$message: Tidak ada data tersedia"),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          controller.getData();
                        },
                        child: const Text("Muat Ulang"),
                      ),
                    ],
                  ),
                ),
              ),

              // ⚓ Footer
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  border: const Border(
                    top: BorderSide(color: Color(0xffe2e8f0)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  "© ${DateTime.now().year} Sistem Antrian Terpadu",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff64748b),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
