import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/edit_data_controller.dart';
import 'package:halowarga/services/firestore_service.dart';

class EditScreen extends StatelessWidget {
  final String type;
  final String content;

  EditScreen({Key? key, required this.type, required this.content})
      : super(key: key);

  final TextStyle textStyle = TextStyle(fontSize: 15);

  final editDataController = Get.find<EditDataController>();

  @override
  Widget build(BuildContext context) {
    editDataController.newData.text = content;
    return Scaffold(
      appBar: AppBar(
        title: Text(type, style: textStyle.copyWith(fontSize: 23)),
        backgroundColor: AppColor.mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              height: 50,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: editDataController.newData,
                style: textStyle,
                keyboardType: type == 'No. Telepon'
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                    hintText: type,
                    hintStyle:
                        textStyle.copyWith(color: AppColor.secondaryText),
                    filled: true,
                    fillColor: AppColor.placeholder,
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (editDataController.newData.text != '') {
                    if (type == 'Nama') {
                      FirestoreService.updateName(
                          editDataController.newData.text,
                          userController.loggedUser.value.uid!);

                      Get.back();
                    } else if (type == 'No. Telepon') {
                      if (editDataController.newData.text.contains(',') ||
                          editDataController.newData.text.contains('.')) {
                        Get.snackbar('Kesalahan input data',
                            'inputan harus berupa angka',
                            colorText: Colors.white);
                      } else if (editDataController.newData.text.length < 11 ||
                          editDataController.newData.text.length > 12) {
                        Get.snackbar('Kesalahan input data',
                            'Panjang dari no telepon harus lebih dari 10 dan kurang dari 13',
                            colorText: Colors.white);
                      } else {
                        FirestoreService.updatePhoneNUmber(
                            editDataController.newData.text,
                            userController.loggedUser.value.uid!);
                        Get.back();
                      }
                    } else {
                      FirestoreService.updateAddress(
                          editDataController.newData.text,
                          userController.loggedUser.value.uid!);
                      Get.back();
                    }
                  }
                },
                child: Center(
                  child: Text(
                    'Simpan',
                    style: textStyle.copyWith(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: AppColor.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
