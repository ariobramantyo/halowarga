import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';

class SettingPagePengurus extends StatelessWidget {
  const SettingPagePengurus({Key? key}) : super(key: key);

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
                  children: [
                    Container(
                      height: 51,
                      width: 51,
                      decoration: BoxDecoration(
                          color: AppColor.placeholder, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lorem Ipsum',
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Warga',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: AppColor.white, fontSize: 11),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                color: AppColor.white,
              ))
            ],
          ),
        ));
    ;
  }
}
