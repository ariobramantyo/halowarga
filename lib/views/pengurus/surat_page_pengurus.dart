import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/views/widget/list_surat.dart';

class SuratPagePengurus extends StatefulWidget {
  const SuratPagePengurus({Key? key}) : super(key: key);

  @override
  _SuratPagePengurusState createState() => _SuratPagePengurusState();
}

class _SuratPagePengurusState extends State<SuratPagePengurus>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengajuan Surat',
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
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: AppColor.mainColor,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TabBar(
                unselectedLabelColor: AppColor.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColor.mainColor,
                labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                indicator: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12)),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Surat Diminta',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Surat Diserahkan',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: AppColor.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // tab surat diminta
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('document')
                        .where('status', isEqualTo: 'Diproses')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // var documents = snapshot.data!.docs
                        //     .map((value) => Document.fromSnapshot(value
                        //         as QueryDocumentSnapshot<Map<String, dynamic>>))
                        //     .toList();

                        return ListSurat(
                          documents: snapshot.data!.docs,
                          role: 'Pengurus',
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  // tab surat diserahkan
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('document')
                        .where('status', isNotEqualTo: 'Diproses')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // var documents = snapshot.data!.docs
                        //     .map((value) => Document.fromSnapshot(value
                        //         as QueryDocumentSnapshot<Map<String, dynamic>>))
                        //     .toList();

                        return ListSurat(
                            documents: snapshot.data!.docs, role: 'Pengurus');
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
