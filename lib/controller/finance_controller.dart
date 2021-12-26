import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:intl/intl.dart';

class FinanceReportController extends GetxController {
  late TextEditingController titleCont;
  late TextEditingController balanceCont;
  var dateSubmit = 'Pilih tanggal'.obs;
  var totalBalance = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    titleCont = TextEditingController();
    balanceCont = TextEditingController();
    totalBalance.value = await FirestoreService.getTotalBalance();
  }

  @override
  void dispose() {
    titleCont.dispose();
    balanceCont.dispose();
    super.dispose();
  }

  void changeDate(DateTime date) {
    dateSubmit.value = DateFormat('d MMM yyyy').format(date);
  }
}
