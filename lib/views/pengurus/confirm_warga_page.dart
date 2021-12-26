import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/widget/card_person.dart';

class ConfirmWargaPage extends StatelessWidget {
  const ConfirmWargaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Penerimaan Warga'),
          backgroundColor: AppColor.mainColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('status', isEqualTo: 'waiting')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var _user = UserData.fromSnapshot(snapshot.data!.docs[index]
                      as QueryDocumentSnapshot<Map<String, dynamic>>);
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CardPerson(
                                name: _user.name!,
                                address: _user.address!,
                                imageUrl: _user.imageUrl,
                                role: _user.role!,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                      onPressed: () =>
                                          FirestoreService.acceptCitizen(
                                              _user.uid!,
                                              'rejected',
                                              _user.name!),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: AppColor.red,
                                      ),
                                      child: Text('Tolak',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColor.white,
                                          ))),
                                  OutlinedButton(
                                      onPressed: () =>
                                          FirestoreService.acceptCitizen(
                                              _user.uid!,
                                              'accepted',
                                              _user.name!),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: AppColor.mainColor,
                                      ),
                                      child: Text('Terima',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColor.white,
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
