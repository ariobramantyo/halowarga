import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/services/auth_service.dart';

class SettingPagePengurus extends StatelessWidget {
  SettingPagePengurus({Key? key}) : super(key: key);

  final _userController = Get.find<UserController>();

  void _logout() {
    AuthService.signOut();
    _userController.statusSignUp.value = '';
    _userController.roleSignUp.value = '';
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
                child: Row(
                  children: [
                    Container(
                      height: 51,
                      width: 51,
                      decoration: BoxDecoration(
                          color: AppColor.placeholder, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lorem Ipsum',
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Warga',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: AppColor.white, fontSize: 11),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                color: AppColor.white,
                child: Center(
                  child: IconButton(
                    onPressed: _logout,
                    icon: Icon(Icons.logout),
                  ),
                ),
              ))
            ],
          ),
        ));
    ;
  }
}
