import 'package:flutter/cupertino.dart';
import 'package:halowarga/const/colors.dart';

class CardPengumuman extends StatelessWidget {
  CardPengumuman(
      {Key? key,
      required this.title,
      required this.desc,
      required this.date,
      required this.time})
      : super(key: key);

  final String title;
  final String desc;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
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
                      date.substring(0, 2),
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 24),
                    ),
                    Text(
                      date.substring(3, 6),
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
                      title,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      desc,
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
            time.substring(0, 5),
            style: TextStyle(color: AppColor.secondaryText, fontSize: 11),
          )
        ],
      ),
    );
  }
}
