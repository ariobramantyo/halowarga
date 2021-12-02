import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:halowarga/const/colors.dart';
import 'package:get/get.dart';
import 'package:halowarga/controller/obscure.dart';
import 'package:halowarga/views/login_page.dart';
import 'package:halowarga/views/signup_page.dart';

class WrapperLogin extends StatelessWidget {
  WrapperLogin({Key? key}) : super(key: key);

  final obscureController = Get.put(ObscureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/image/login_vector.svg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 80),
            Text(
              'Selamat datang di Halowarga\nAplikasi untuk memudahkan kepengurusan RT',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.secondaryText, fontSize: 13),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () => Get.to(() => LoginPage()),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(353, 56),
                primary: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.to(() => SignUpPage()),
              child: Text(
                'Daftar',
                style: TextStyle(
                    color: AppColor.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(353, 56),
                primary: AppColor.white,
                side: BorderSide(color: AppColor.mainColor, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
