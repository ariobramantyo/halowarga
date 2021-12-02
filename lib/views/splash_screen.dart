import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:halowarga/const/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Center(
        child: Container(
          width: 120,
          child: SvgPicture.asset(
            'assets/image/logo_white.svg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
