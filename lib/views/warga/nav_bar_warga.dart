import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/navbar_warga_controller.dart';
import 'package:halowarga/views/warga/home_page_warga.dart';
import 'package:halowarga/views/warga/setting_page_warga.dart';
import 'package:halowarga/views/warga/surat_page_warga.dart';
import 'package:halowarga/views/warga/warga_page.dart';

class NavBarWarga extends StatelessWidget {
  NavBarWarga({Key? key}) : super(key: key);

  final List<Widget> _listPage = [
    HomePageWarga(),
    SuratPageWarga(),
    WargaPage(),
    SettingPageWarga()
  ];

  final _navBarController = Get.put(NavBarWargaController());

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
