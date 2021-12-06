import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';

class WargaPage extends StatelessWidget {
  WargaPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warga',
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
                  Text(
                    '44 Warga',
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              height: 76,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColor.black,
                ),
                decoration: InputDecoration(
                    hintText: 'Cari Warga..',
                    hintStyle:
                        TextStyle(fontSize: 13, color: AppColor.secondaryText),
                    filled: true,
                    fillColor: AppColor.placeholder,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.secondaryText,
                      size: 24,
                    )),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
              color: AppColor.white,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    height: 45,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: AppColor.placeholder,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor sit amet',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: AppColor.secondaryText,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Warga',
                          style: TextStyle(
                              color: AppColor.secondaryText, fontSize: 13),
                        )
                      ],
                    ),
                  );
                },
              ),
            ))
          ],
        )));
  }
}
