import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/edit_data_controller.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/services/auth_service.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/edit_page.dart';

class SettingPagePengurus extends StatelessWidget {
  SettingPagePengurus({Key? key}) : super(key: key);

  final _userController = Get.find<UserController>();
  final editDataController = Get.put(EditDataController());

  void _logout() {
    AuthService.signOut();
    _userController.statusSignUp.value = '';
    _userController.roleSignUp.value = '';
  }

  Widget dataContainer(String title, String content, bool isEditable) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.placeholder, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12)),
              Container(
                width: isEditable ? Get.width / 1.6 : null,
                child: Text(content == '' ? 'no nomber' : content,
                    style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
          if (isEditable)
            GestureDetector(
              onTap: () =>
                  Get.to(() => EditScreen(type: title, content: content)),
              child: Container(
                height: 24,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'edit',
                    style: TextStyle(color: AppColor.mainColor, fontSize: 15),
                  ),
                ),
              ),
            )
        ],
      ),
    );
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.placeholder,
                            ),
                            child: _userController.loggedUser.value.imageUrl ==
                                    ''
                                ? Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 47,
                                      color: AppColor.secondaryText,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Image.network(
                                        _userController
                                                .loggedUser.value.imageUrl ??
                                            'https://ppa-feui.com/wp-content/uploads/2013/01/nopict-300x300.png',
                                        fit: BoxFit.cover),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: -6,
                          right: -6,
                          child: GestureDetector(
                            onTap: () async {
                              await editDataController
                                  .updateUserPhoto(
                                      _userController.loggedUser.value.uid!)
                                  .then((imageUrl) {
                                if (imageUrl != '') {
                                  _userController.loggedUser.update(
                                    (user) {
                                      user!.imageUrl = imageUrl;
                                    },
                                  );
                                  _userController.loggedUser.refresh();
                                  FirestoreService.updateUserPhoto(
                                      _userController.loggedUser.value.uid!,
                                      imageUrl);
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.secondaryText.withOpacity(0.7),
                              ),
                              child: Icon(
                                Icons.photo_camera,
                                color: AppColor.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: Get.width / 1.8,
                                child: Obx(
                                  () => Text(
                                    _userController.loggedUser.value.name!,
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 24,
                                        height: 1,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                            GestureDetector(
                              onTap: () => Get.to(
                                () => EditScreen(
                                    type: 'Nama',
                                    content:
                                        _userController.loggedUser.value.name!),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColor.white,
                              ),
                            )
                          ],
                        ),
                        Text(
                          _userController.loggedUser.value.role!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: AppColor.white, fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      color: AppColor.white,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          SizedBox(height: 20),
                          Obx(
                            () => dataContainer(
                              'Alamat',
                              _userController.loggedUser.value.address!,
                              true,
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () => dataContainer(
                              'No. Telepon',
                              _userController.loggedUser.value.no!,
                              true,
                            ),
                          ),
                          SizedBox(height: 20),
                          dataContainer(
                            'Email',
                            _userController.loggedUser.value.email ?? '',
                            false,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _logout,
                              child: Container(
                                height: 40,
                                width: 117,
                                margin: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.mainColor),
                                child: Center(
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ));
    ;
  }
}
