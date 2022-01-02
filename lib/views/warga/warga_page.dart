import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/search_warga_controller.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/views/widget/card_person.dart';

class WargaPage extends StatelessWidget {
  WargaPage({Key? key}) : super(key: key);

  final _searchController = Get.put(SearchWargaController());

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warga',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'RT 03 Kelurahan Pesalakan',
                        style: TextStyle(color: AppColor.white, fontSize: 11),
                      )
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data!.docs.length} Warga',
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        );
                      }
                      return Text(
                        '0 Warga',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 76,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                child: TextFormField(
                  controller: _searchController.searchController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.black,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Cari Warga..',
                      hintStyle: TextStyle(
                          fontSize: 13, color: AppColor.secondaryText),
                      filled: true,
                      fillColor: AppColor.placeholder,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.secondaryText,
                        size: 24,
                      )),
                  onChanged: (value) {
                    _searchController.inputSearch.value = value.toLowerCase();
                    _searchController.search();
                    print('search ' + _searchController.inputSearch.value);
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: AppColor.white,
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .where('status', isEqualTo: 'accepted')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var listWarga = snapshot.data!.docs
                        .map((warga) => UserData.fromSnapshot(warga
                            as QueryDocumentSnapshot<Map<String, dynamic>>))
                        .toList();

                    _searchController.initializeData(listWarga);

                    return Obx(() => ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: _searchController.wargaToDisplay.length,
                          itemBuilder: (context, index) {
                            return CardPerson(
                              name:
                                  _searchController.wargaToDisplay[index].name!,
                              address: _searchController
                                  .wargaToDisplay[index].address!,
                              imageUrl: _searchController
                                  .wargaToDisplay[index].imageUrl,
                              role:
                                  _searchController.wargaToDisplay[index].role!,
                            );
                          },
                        ));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ))
          ],
        )));
  }
}
