import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/document.dart';
import 'package:halowarga/views/widget/list_surat.dart';

class DaftarPengajuanSuratPage extends StatelessWidget {
  DaftarPengajuanSuratPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Pengajuan Surat',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: AppColor.mainColor,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .collection('listDocuments')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var documents = snapshot.data!.docs
                .map((value) => Document.fromSnapshot(
                    value as QueryDocumentSnapshot<Map<String, dynamic>>))
                .toList();
            print(snapshot.data!.docs.first.id);
            return ListSurat(
              documents: snapshot.data!.docs,
              role: 'Warga',
            );
            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     var document = Document.fromSnapshot(snapshot.data!.docs[index]
            //         as QueryDocumentSnapshot<Map<String, dynamic>>);
            //     return Container(
            //         // height: 100,
            //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: AppColor.white,
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black12,
            //                   blurRadius: 5,
            //                   spreadRadius: 1,
            //                   offset: Offset(2, 2))
            //             ]),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               children: [
            //                 Icon(
            //                   Icons.description,
            //                   color: AppColor.mainColor,
            //                   size: 28,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       document.type,
            //                       style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                     Text(document.date,
            //                         style: TextStyle(
            //                           fontSize: 10,
            //                         ))
            //                   ],
            //                 )
            //               ],
            //             ),
            //             Divider(height: 25),
            //             Text(document.name,
            //                 style: TextStyle(
            //                     fontSize: 15, fontWeight: FontWeight.w500)),
            //             Text(document.desc, style: TextStyle(fontSize: 11)),
            //             Container(
            //               padding: EdgeInsets.all(3),
            //               margin: EdgeInsets.only(top: 5),
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5),
            //                   color: document.status == 'Selesai'
            //                       ? AppColor.mainColor.withOpacity(0.2)
            //                       : Colors.amber.withOpacity(0.3)),
            //               child: Text(document.status,
            //                   style: TextStyle(
            //                       fontSize: 11,
            //                       fontWeight: FontWeight.w600,
            //                       color: document.status == 'Selesai'
            //                           ? AppColor.mainColor
            //                           : Colors.orange)),
            //             )
            //           ],
            //         ));
            //   },
            // );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
