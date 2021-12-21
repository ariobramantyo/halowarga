import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/services/auth_service.dart';

class WaitingPageWarga extends StatelessWidget {
  WaitingPageWarga({Key? key}) : super(key: key);

  final _userController = Get.find<UserController>();

  final String message =
      'Proses pendaftaran Anda telah selesai\nmohon untuk menunggu pengurus untuk mengkonfirmasi pendaftaran Anda\nsetelah itu anda baru bisa menggunakan aplikasi ini';

  void _logout() {
    AuthService.signOut();
    _userController.statusSignUp.value = '';
    _userController.roleSignUp.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/image/login_vector.svg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: _logout,
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
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
