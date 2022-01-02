import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/finance_controller.dart';
import 'package:halowarga/model/financeReport.dart';
import 'package:halowarga/services/firestore_service.dart';

class AddIncomePage extends StatelessWidget {
  AddIncomePage({Key? key, required this.type}) : super(key: key);

  final String type;

  final _financeCont = Get.put(FinanceReportController());

  Widget _formField(TextEditingController controller, String hint) {
    return Container(
      height: 56,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 13,
          color: AppColor.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13, color: AppColor.secondaryText),
          filled: true,
          fillColor: AppColor.placeholder,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Form tidak boleh kosong';
          }
        },
      ),
    );
  }

  void saveChange() async {
    if (_financeCont.titleCont.text != '' &&
        _financeCont.balanceCont.text != '' &&
        _financeCont.dateSubmit.value != 'Pilih tanggal') {
      // ambil total uang kas RT
      _financeCont.totalBalance.value =
          await FirestoreService.getTotalBalance();

      int jumPemasukan = int.parse(_financeCont.balanceCont.text);

      if (type == 'outcome') {
        jumPemasukan *= -1;
      }

      FirestoreService.addIncome(
          FinanceReport(
            title: _financeCont.titleCont.text,
            income: jumPemasukan,
            currentTotalBalance: _financeCont.totalBalance.value + jumPemasukan,
            day: _financeCont.dateSubmit.value.substring(0, 2),
            month: _financeCont.dateSubmit.value.substring(3, 6),
            year: _financeCont.dateSubmit.value.substring(7, 11),
            type: type,
            timeSubmit: DateTime.now().toIso8601String(),
          ),
          type);

      await FirestoreService.updateTotalBalance(jumPemasukan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(type == 'income' ? 'Tambah Pemasukkan' : 'Tambah Pengeluaran'),
        backgroundColor: AppColor.mainColor,
      ),
      body: SafeArea(
        child: Form(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
            _formField(_financeCont.titleCont, 'Judul'),
            SizedBox(height: 20),
            _formField(_financeCont.balanceCont,
                type == 'income' ? 'Jumlah Pemasukkan' : 'Jumlah Pengeluaran'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  currentTime: DateTime.now(),
                  theme: DatePickerTheme(
                      doneStyle: TextStyle(color: AppColor.mainColor)),
                  onConfirm: (date) {
                    _financeCont.changeDate(date);
                  },
                );
              },
              child: Container(
                height: 56,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColor.placeholder,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          _financeCont.dateSubmit.value,
                          style: TextStyle(fontSize: 13, color: AppColor.black),
                        )),
                    Icon(
                      Icons.expand_more,
                      color: AppColor.mainColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                saveChange();
                Navigator.pop(context);
              },
              child: Text('Simpan',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(353, 50),
                primary: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
