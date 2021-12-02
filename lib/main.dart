import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/views/wrapper_login.dart';
import 'package:halowarga/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Halowarga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WrapperLogin();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
