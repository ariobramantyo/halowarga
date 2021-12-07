import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HaloLaporWargaController extends GetxController {
  late TextEditingController subjekController;
  late TextEditingController ketController;

  @override
  void onInit() {
    super.onInit();
    subjekController = TextEditingController();
    ketController = TextEditingController();
  }

  @override
  void dispose() {
    subjekController.dispose();
    ketController.dispose();
    super.dispose();
  }
}
