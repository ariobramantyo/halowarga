import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:halowarga/views/wrapper.dart';
import 'package:halowarga/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Halowarga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      builder: EasyLoading.init(),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Wrapper();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
