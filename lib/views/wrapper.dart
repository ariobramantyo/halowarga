import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/services/auth_service.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/login_page.dart';
import 'package:halowarga/views/pengurus/navbar_pengurus.dart';
import 'package:halowarga/views/warga/nav_bar_warga.dart';
import 'package:halowarga/views/warga/waiting_page_warga.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.firebaseUserStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<dynamic>?>(
            future: FirestoreService.isUserCitizen(snapshot.data),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data![0] != null && snapshot.data![1] != null) {
                  return snapshot.data![0] // check if user is a citizen
                      ? snapshot.data![1] // check if user is accepted
                          ? NavBarWarga()
                          : WaitingPageWarga()
                      : NavBarPengurus();
                } else {
                  return userController.roleSignUp.value ==
                          'Warga' // check if user is a citizen
                      ? userController.statusSignUp.value ==
                              'accepted' // check if user is accepted
                          ? NavBarWarga()
                          : WaitingPageWarga()
                      : NavBarPengurus();
                }
              }
              return LoginPage();
            },
          );
        }
        return LoginPage();
      },
    );
  }
}
