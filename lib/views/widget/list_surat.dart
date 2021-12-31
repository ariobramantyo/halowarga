import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/services/firestore_service.dart';

class ListSurat extends StatelessWidget {
  ListSurat({Key? key, required this.documents, required this.role})
      : super(key: key);

  final List<QueryDocumentSnapshot> documents;
  final String role;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        var document = documents[index];
        return Container(
            // height: 100,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2, 2))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: AppColor.mainColor,
                      size: 28,
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['type'],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(document['date'],
                            style: TextStyle(
                              fontSize: 10,
                            ))
                      ],
                    )
                  ],
                ),
                Divider(height: 25),
                Text(document['name'],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Text(document['desc'], style: TextStyle(fontSize: 11)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: document['status'] == 'Selesai'
                              ? AppColor.mainColor.withOpacity(0.2)
                              : Colors.amber.withOpacity(0.3)),
                      child: Text(document['status'],
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: document['status'] == 'Selesai'
                                  ? AppColor.mainColor
                                  : Colors.orange)),
                    ),
                    if (role == 'Pengurus' && document['status'] == 'Diproses')
                      OutlinedButton(
                          onPressed: () => FirestoreService.documentDone(
                              document['id'], document['senderId']),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: AppColor.white,
                              side: BorderSide(color: AppColor.mainColor)),
                          child: Text('Selesai',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.mainColor,
                              ))),
                  ],
                )
              ],
            ));
      },
    );
  }
}
