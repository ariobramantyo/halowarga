import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/surat_warga.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/document.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:intl/intl.dart';

class SuratPageWarga extends StatelessWidget {
  SuratPageWarga({Key? key}) : super(key: key);

  final _controller = Get.put(SuratWargaController());
  final _userController = Get.find<UserController>();

  final _titleFormStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  final _jenisSuratItems = [
    'Surat Pengantar SKCK',
    'Surat Keterangan Domisili Usaha',
    'Surat 1',
    'Surat 2',
    'Surat 3'
  ];

  String _selectedJenisSurat = '';

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

  void _submit() {
    if (_selectedJenisSurat != '' &&
        _controller.namaController.text != '' &&
        _controller.tanggalController.text != '' &&
        _controller.ketController.text != '') {
      final String id = DateTime.now().toIso8601String();
      FirestoreService.sendReport(
          Document(
              id: id,
              type: _selectedJenisSurat,
              name: _controller.namaController.text,
              date: _controller.tanggalController.text,
              desc: _controller.ketController.text,
              sender: _userController.loggedUser.value.name!,
              senderId: _userController.loggedUser.value.uid!,
              timeSubmit: DateFormat('kk:mm:ss').format(DateTime.now())),
          id);

      _selectedJenisSurat = '';
      _controller.namaController.text = '';
      _controller.tanggalController.text = '';
      _controller.ketController.text = '';
    }
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
                      'Pengajuan Surat',
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
                        'Jenis Surat',
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
                            'PIlih Jenis Surat',
                            style: TextStyle(fontSize: 13),
                          ),
                          items: _jenisSuratItems
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                                child: Text(value), value: value);
                          }).toList(),
                          onChanged: (value) =>
                              _selectedJenisSurat = value.toString(),
                          onSaved: (value) =>
                              _selectedJenisSurat = value.toString(),
                          validator: (value) {
                            if (value == null) {
                              return "Jenis surat tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Yang Membutuhkan Surat',
                        style: _titleFormStyle,
                      ),
                      _formField(_controller.namaController, 'Nama'),
                      SizedBox(height: 20),
                      Text(
                        'Tanggal Pemakaian Surat',
                        style: _titleFormStyle,
                      ),
                      _formField(_controller.tanggalController, 'YYYY-MM-DD'),
                      SizedBox(height: 20),
                      Text(
                        'Untuk Kebutuhan',
                        style: _titleFormStyle,
                      ),
                      _formField(_controller.ketController, 'Kebutuhan',
                          height: 100, maxLines: 3),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _submit,
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
          ),
        ));
  }
}
