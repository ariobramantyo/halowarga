import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/views/widget/card_person.dart';

class WargaPage extends StatelessWidget {
  WargaPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

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
                  Text(
                    '44 Warga',
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              height: 76,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColor.black,
                ),
                decoration: InputDecoration(
                    hintText: 'Cari Warga..',
                    hintStyle:
                        TextStyle(fontSize: 13, color: AppColor.secondaryText),
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
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
              color: AppColor.white,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('status', isEqualTo: 'accepted')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var _warga = UserData.fromSnapshot(snapshot
                                  .data!.docs[index]
                              as QueryDocumentSnapshot<Map<String, dynamic>>);

                          return CardPerson(
                            name: _warga.name!,
                            address: _warga.address!,
                            imageUrl: _warga.imageUrl,
                            role: _warga.role!,
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ))
          ],
        )));
  }
}
