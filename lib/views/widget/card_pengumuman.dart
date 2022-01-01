import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/announce.dart';
import 'package:halowarga/views/detail_announce_page.dart';

class CardPengumuman extends StatelessWidget {
  CardPengumuman({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () =>
            Get.to(() => DetailAnnouncePage(announcement: announcement)),
        child: Container(
          height: 70,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: AppColor.placeholder,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          announcement.date.substring(0, 2),
                          style: TextStyle(
                              color: AppColor.secondaryText, fontSize: 24),
                        ),
                        Text(
                          announcement.date.substring(3, 6),
                          style: TextStyle(
                              color: AppColor.secondaryText, fontSize: 11),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          announcement.desc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: AppColor.secondaryText, fontSize: 11),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                announcement.time.substring(0, 5),
                style: TextStyle(color: AppColor.secondaryText, fontSize: 11),
              )
            ],
          ),
        ),
      ),
    );
  }
}
