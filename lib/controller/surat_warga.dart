import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SuratWargaController extends GetxController {
  late TextEditingController namaController;
  late TextEditingController tanggalController;
  late TextEditingController ketController;

  @override
  void onInit() {
    super.onInit();
    namaController = TextEditingController();
    tanggalController = TextEditingController();
    ketController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    namaController.dispose();
    tanggalController.dispose();
    ketController.dispose();
  }
}
