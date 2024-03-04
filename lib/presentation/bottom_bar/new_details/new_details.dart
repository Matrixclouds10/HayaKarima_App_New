import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/my_colors.dart';
import '../../../data/model/model_news.dart';

class New_details extends StatefulWidget {
  late Data_News data_news;

  New_details(this.data_news);

  @override
  _New_details createState() => _New_details();
}

class _New_details extends State<New_details> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final model = widget.data_news;
    DateTime now = DateTime.parse((model.createdAt));
    String date = DateFormat.yMMMMd().format(now);

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String des = model.description.toString().replaceAll(exp, '');

    // TODO: implement build

    return Scaffold(
      backgroundColor: HexColor(MyColors.gray_light2),
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.white),
        elevation: 3.0,
        title: Text(
          '',
          style: TextStyle(fontSize: 19.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.clear, color: HexColor(MyColors.gray)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  alignment: Alignment.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(3.0.w),
                alignment: Alignment.center,
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
            child: Text(
              model.title,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 30.h,
                left: 15.w,
                right: 15.w,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.access_time_rounded,
                      size: 30.0.sp,
                      color: HexColor(MyColors.gray),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4.w, right: 4.w),
                    alignment: Alignment.center,
                    child: Text(
                      date,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor(MyColors.gray)),
                    ),
                  ),
                ],
              )),
          SizedBox(
            width: width,
            height: 170.0.h,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              placeholder: (context, url) => Image.asset('assets/logo.jpg'),
              errorWidget: (context, url, error) => Image.asset(
                'assets/logo.jpg',
                fit: BoxFit.fill,
              ),
              imageUrl: model.image,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h),
            decoration: BoxDecoration(
                color: HexColor(
                    MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0.r),
                  topRight: Radius.circular(20.0.r),
                  bottomRight: Radius.circular(20.0.r),
                  bottomLeft: Radius.circular(20.0.r),
                )),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ReadMoreText(
                      des.replaceAll('&nbsp;', ' '),
                      trimLines: 9,
                      colorClickableText: HexColor(MyColors.green),
                      trimMode: TrimMode.Line,
                      style: TextStyle(
                          fontSize: 16.sp, color: HexColor(MyColors.black)),
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
