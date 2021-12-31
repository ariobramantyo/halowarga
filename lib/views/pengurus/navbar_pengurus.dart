import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/navbar_pengurus_controller.dart';
import 'package:halowarga/views/pengurus/home_page_pengurus.dart';
import 'package:halowarga/views/setting_page.dart';
import 'package:halowarga/views/pengurus/surat_page_pengurus.dart';
import 'package:halowarga/views/pengurus/warga_page_pengurus.dart';

class NavBarPengurus extends StatelessWidget {
  NavBarPengurus({Key? key}) : super(key: key);

  final List<Widget> _listPage = [
    HomePagePengurus(),
    SuratPagePengurus(),
    WargaPagePengurus(),
    SettingPage()
  ];

  final _navBarController = Get.put(NavBarPengurusController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            selectedItemColor: AppColor.mainColor,
            unselectedItemColor: AppColor.secondaryText,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.description), label: 'Surat'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Warga'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Pengaturan')
            ],
            currentIndex: _navBarController.selectedTab.value,
            onTap: (value) => _navBarController.changeTab(value),
          ),
          body: _listPage.elementAt(_navBarController.selectedTab.value),
        ));
  }
}
