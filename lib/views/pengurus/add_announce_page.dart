import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/add_announce_contr.dart';
import 'package:halowarga/model/announce.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:intl/intl.dart';

class AddAnnouncePage extends StatelessWidget {
  AddAnnouncePage({Key? key}) : super(key: key);

  final _announceCont = Get.put(AddAnnounceController());

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
        // textInputAction: TextInputAction.done,
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
      appBar: AppBar(
          title: Text('Buat Pengumuman'), backgroundColor: AppColor.mainColor),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
            _formField(_announceCont.subject, 'Judul'),
            SizedBox(height: 20),
            _formField(_announceCont.desc, 'Isi pengumuman',
                height: 200, maxLines: 8),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (_announceCont.subject.text != '' &&
                    _announceCont.desc.text != '') {
                  print('masuk ke kirim');
                  FirestoreService.addAnnounce(Announcement(
                    title: _announceCont.subject.text,
                    desc: _announceCont.desc.text,
                    date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    time: DateFormat('kk:mm:ss').format(DateTime.now()),
                  ));
                  print('selesai kirim');
                  Navigator.pop(context);
                }
              },
              child: Text('Kirim',
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
        ),
      ),
    );
  }
}
