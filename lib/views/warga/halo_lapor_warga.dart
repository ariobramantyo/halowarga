import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/halolapor_warga_controller.dart';
import 'package:halowarga/model/report.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:intl/intl.dart';

class HaloLaporWarga extends StatelessWidget {
  HaloLaporWarga({Key? key}) : super(key: key);

  final _controller = Get.put(HaloLaporWargaController());

  final _titleFormStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  final _kategoriLaporan = ['Maling', 'Keributan', 'Kerusakan Fasilitas'];

  String _selectedKategoriLaporan = '';

  Widget _formField(TextEditingController controller, String hint,
      {double? height, int? maxLines}) {
    return Container(
      height: height ?? 56,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 5),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 13,
          color: AppColor.black,
        ),
        maxLines: maxLines ?? 1,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13, color: AppColor.secondaryText),
          filled: true,
          fillColor: AppColor.placeholder,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: AppColor.mainColor,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo Lapor',
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'RT 03 Kelurahan Pesalakan',
                  style: TextStyle(color: AppColor.white, fontSize: 11),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: AppColor.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Kategori Laporan',
                    style: _titleFormStyle,
                  ),
                  Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.placeholder,
                    ),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      dropdownColor: AppColor.white,
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 13),
                      hint: Text(
                        'PIlih Kategori Laporan',
                        style: TextStyle(fontSize: 13),
                      ),
                      items: _kategoriLaporan
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            child: Text(value), value: value);
                      }).toList(),
                      onChanged: (value) =>
                          _selectedKategoriLaporan = value.toString(),
                      onSaved: (value) =>
                          _selectedKategoriLaporan = value.toString(),
                      validator: (value) {
                        if (value == null) {
                          return "Kategori laporan tidak boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sujek Laporan',
                    style: _titleFormStyle,
                  ),
                  _formField(_controller.subjekController, 'Subjek laporan'),
                  SizedBox(height: 20),
                  Text(
                    'Keterangan',
                    style: _titleFormStyle,
                  ),
                  _formField(_controller.ketController, 'Keterangan',
                      height: 100, maxLines: 3),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.subjekController.text != '' &&
                          _controller.ketController.text != '' &&
                          _selectedKategoriLaporan != '') {
                        FirestoreService.addReport(
                          Report(
                            category: _selectedKategoriLaporan,
                            title: _controller.subjekController.text,
                            desc: _controller.ketController.text,
                            sender: userController.loggedUser.value.name!,
                            date: DateFormat('dd MMM yyyy')
                                .format(DateTime.now()),
                            time: DateFormat('kk:mm:ss').format(DateTime.now()),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Kirim',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(353, 56),
                      primary: AppColor.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
