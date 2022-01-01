import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/announce.dart';

class DetailAnnouncePage extends StatelessWidget {
  DetailAnnouncePage({Key? key, required this.announcement}) : super(key: key);

  final Announcement announcement;

  Widget _dataContainer(String title, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.placeholder, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12)),
          Text(content,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                      title == 'Judul' ? FontWeight.w500 : FontWeight.normal))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengumuman'),
        backgroundColor: AppColor.mainColor,
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 20),
            _dataContainer('Judul', announcement.title),
            SizedBox(height: 20),
            _dataContainer('Deskripsi', announcement.desc),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(announcement.date), Text(announcement.time)],
            )
          ],
        ),
      ),
    );
  }
}
