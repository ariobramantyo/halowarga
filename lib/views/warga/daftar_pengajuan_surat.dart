import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
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
            return ListSurat(
              documents: snapshot.data!.docs,
              role: 'Warga',
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
