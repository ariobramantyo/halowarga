import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddAnnounceController extends GetxController {
  late TextEditingController subject;
  late TextEditingController desc;

  @override
  void onInit() {
    super.onInit();
    subject = TextEditingController();
    desc = TextEditingController();
  }

  @override
  void dispose() {
    subject.dispose();
    desc.dispose();
    super.dispose();
  }
}
