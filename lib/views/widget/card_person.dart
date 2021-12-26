import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';

class CardPerson extends StatelessWidget {
  CardPerson(
      {Key? key,
      required this.name,
      required this.address,
      required this.imageUrl,
      required this.role})
      : super(key: key);

  final String name;
  final String address;
  final String? imageUrl;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.placeholder,
                ),
                child: imageUrl == ''
                    ? Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: AppColor.secondaryText,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                            imageUrl ??
                                'https://ppa-feui.com/wp-content/uploads/2013/01/nopict-300x300.png',
                            fit: BoxFit.fill),
                      ),
              ),
              SizedBox(width: 10),
              Container(
                width: Get.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2),
                    Text(
                      address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1,
                          color: AppColor.secondaryText,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            role,
            style: TextStyle(color: AppColor.secondaryText, fontSize: 13),
          )
        ],
      ),
    );
  }
}
