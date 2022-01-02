// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:halowarga/model/user.dart';

class SearchWargaController extends GetxController {
  late TextEditingController searchController;
  var inputSearch = ''.obs;
  var warga = List<UserData>.empty().obs;
  var wargaToDisplay = List<UserData>.empty().obs;

  @override
  void onInit() async {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search() {
    if (inputSearch.value != '') {
      wargaToDisplay.value = warga.where((search) {
        var wargaName = search.name!.toLowerCase();
        return wargaName.contains(inputSearch.value);
      }).toList();
    } else {
      wargaToDisplay.value = List<UserData>.from(warga);
    }
    wargaToDisplay.refresh();
  }

  void initializeData(List<UserData> listWarga) async {
    warga.value = List<UserData>.from(listWarga);
    wargaToDisplay.value = List<UserData>.from(listWarga);
  }
}
